SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[insertPrescriptionTransmittal]
  @PDID INTEGER, @DeliveryMethod INTEGER, @TransFlags INTEGER, 
  @PrescType TINYINT, @QueuedDate DATETIME = NULL, @ForceSend BIT = 0,@mailDeliveryMethod INTEGER = 0,@SIGNED BIT =0
AS
	DECLARE @bUpdatePrescriptionStatus AS BIT, @NEWDELIVERYMETHOD AS INTEGER, @bDontCat2Insert AS BIT,
			@CheckForPrevious AS BIT, @DrSureScriptEnabled AS BIT, @CheckCompound AS BIT
			
  SET @bUpdatePrescriptionStatus = 0
  SET @DrSureScriptEnabled = 0
  SET @NEWDELIVERYMETHOD = @DeliveryMethod 
  SET @CheckForPrevious = 0
  SET @bDontCat2Insert = 0 /* Dont insert a category 2 drug due to duplicates */
  SET @CheckCompound = 0 /* Dont send compound Drug electronically */

  IF @QueuedDate IS NULL
    BEGIN
      SET @QueuedDate = GETDATE()
    END
  IF EXISTS (SELECT pt_id FROM prescription_transmittals WHERE pd_id = @PDID AND delivery_method = @DeliveryMethod AND response_date IS NULL)
    BEGIN           
      IF @ForceSend <> 0
	BEGIN
	  UPDATE prescription_transmittals SET queued_date = @QueuedDate, send_date = NULL WHERE pd_id = @PDID AND delivery_method = @DeliveryMethod AND response_date IS NULL
	END
    END
    
  ELSE
    BEGIN
		/* Check if the prescription is going to sure script, if so check if
		   doctor is authorized. If doctor is not authorized , convert the
		   prescription into a fax */
		  IF @DeliveryMethod = 262144
		BEGIN
			 select @DrSureScriptEnabled = ss_enable from doctors D 
			INNER JOIN prescriptions P on D.dr_id = P.dr_id
			INNER JOIN prescription_details PD on P.pres_id = PD.pres_id
			where PD.pd_id = @PDID and ss_enable is not null		

			IF @DrSureScriptEnabled = 0 
		/* Doctor is not authorized for sure script, converting prescription to a fax */
			BEGIN
			SET @NEWDELIVERYMETHOD = 1	
	 		/*UPDATE prescriptions set pres_delivery_method = @NEWDELIVERYMETHOD
	 			where pres_id = (select pres_id from prescription_details where pd_id = @PDID)	*/
			IF EXISTS (SELECT pt_id FROM prescription_transmittals WHERE pd_id = @PDID AND response_date IS NULL)
				  BEGIN
        		   SET @bDontCat2Insert = 1 /* Duplicate cat >=2 drug */
				  END     
			END 		
		END	
		
		   /*****************ADDED FOR COMPOUNDING ****************/
		/* Check if new delivery method is electronic, if then check if this is a compound drug
		if its a compound drug convert the script to a fax */
		IF @NEWDELIVERYMETHOD > 2
		BEGIN
			SELECT @CheckCompound = compound FROM prescription_details WHERE pd_id=@PDID
			IF @CheckCompound = 1
			BEGIN
				SET @NEWDELIVERYMETHOD = 1	
		 		/*UPDATE prescriptions set pres_delivery_method = @NEWDELIVERYMETHOD
		 			where pres_id = (select pres_id from prescription_details where pd_id = @PDID)	*/
				IF EXISTS (SELECT pt_id FROM prescription_transmittals WHERE pd_id = @PDID AND response_date IS NULL)
					  BEGIN
	        	   		SET @bDontCat2Insert = 1 /* Duplicate cat >=2 drug */
					  END 
			END    
		END
	   /*****************END FOR COMPOUNDING ****************/
		 /*Check if mail order delivery with no patient member info */
		
		 
		IF @mailDeliveryMethod =1 
		BEGIN
			SET @NEWDELIVERYMETHOD = 1
		END

		 /* Check if the drug is a class 2 or above (OR MAIL ORDER MEMBER NOT PRESENT). If yes, it cannot be sent as
		  an electronic transmission */
		IF EXISTS 
		(
			select A.ddid from prescription_details A INNER JOIN RMIID1 B on A.ddid = B.MEDID where B.MED_REF_DEA_CD >= 2 
			and A.pd_id = @PDID
		)      
			BEGIN				
				/* Don't modify online pharmacies */				
				If @SIGNED <> 1 /* Check details to make sure we set the right delivery method  */
				BEGIN
					IF EXISTS 
					(
						SELECT state FROM epcs_state_map where state in 
						(
							select dr_state state from doctors dr inner join prescriptions p on 
							dr.dr_id = p.dr_id inner join prescription_details pd on 
							p.pres_id = pd.pres_id where pd.pd_id =@PDID
							
							union
							
							select pharm_state state from pharmacies ph inner join prescriptions p on 
							ph.pharm_id  = p.pharm_id inner join prescription_details pd on 
							p.pres_id = pd.pres_id where pd.pd_id=@PDID
						)
					)
					BEGIN
						SET @bDontCat2Insert = 1; /* Disallow faxing in these states */
					END
				END
				
				
				
				
				IF @DeliveryMethod > 2  and @SIGNED <> 1
				BEGIN
				 SET @NEWDELIVERYMETHOD = 1	
				END	

				IF EXISTS (select pharm_company_name from pharmacies Ph inner join prescriptions P 
				  on Ph.pharm_id = P.pharm_id INNER JOIN prescription_details PD on P.pres_id = PD.pres_id inner join 
				  rnmmidndc R on PD.DDID = R.MEDID where PD.pd_id = @PDID and R.MED_REF_DEA_CD = 2 and @SIGNED <> 1)	
					BEGIN
					 SET @bDontCat2Insert = 1  /* Dont send SCHEDULED II toany pharmacy */
					END
					
				/* Dont insert duplicate schedule drug */
			    
				IF EXISTS (SELECT pt_id FROM prescription_transmittals WHERE pd_id = @PDID AND response_date IS NULL)
				  BEGIN
					SET @bDontCat2Insert = 1 /* Duplicate cat >=2 drug */
				  END                  
			END
	     
	     /*
			Control Substance should not be FAXED, period.
	     */
	    IF @NEWDELIVERYMETHOD = 1  AND EXISTS 
		(
			select A.ddid from prescription_details A INNER JOIN RMIID1 B on A.ddid = B.MEDID where B.MED_REF_DEA_CD >= 2 
			and A.pd_id = @PDID
		) 
		BEGIN
			SET @bDontCat2Insert = 1
		END
		
		IF @bDontCat2Insert <> 1
		   BEGIN
				/* Check if we changed the delivery method, if so the original 
				 prescriptions table has to be updated */
				/*IF @NEWDELIVERYMETHOD <> @DeliveryMethod
				BEGIN
				 UPDATE prescriptions set pres_delivery_method = @NEWDELIVERYMETHOD
				 where pres_id = (select pres_id from prescription_details where pd_id = @PDID)
				END*/
				INSERT INTO prescription_transmittals (pd_id, pres_id, queued_date, delivery_method, transmission_flags,prescription_type)
				SELECT @PDID, pres_id, @QueuedDate, @NEWDELIVERYMETHOD, @TransFlags, @PrescType FROM prescription_details 
				WHERE pd_id = @PDID
		   END
	END
    
    
  IF @@ROWCOUNT <> 0
    BEGIN
      SET @bUpdatePrescriptionStatus = 1
    END
    
    
  IF EXISTS (SELECT ps_id FROM prescription_status WHERE pd_id = @PDID AND delivery_method = @NEWDELIVERYMETHOD)
    BEGIN
      IF (@bUpdatePrescriptionStatus <> 0 AND @bDontCat2Insert <> 1)
		BEGIN
			UPDATE prescription_status SET queued_date = @QueuedDate, response_type = NULL, response_date = NULL, 
			response_text = NULL, confirmation_id = NULL FROM prescription_status WHERE pd_id = @PDID AND 
			delivery_method = @NEWDELIVERYMETHOD
		END	
    END
  ELSE 
    BEGIN
     IF (@bDontCat2Insert <> 1)
		BEGIN
			INSERT INTO prescription_status (pd_id, delivery_method, queued_date) VALUES (@PDID, @NEWDELIVERYMETHOD, @QueuedDate)
		END
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
