SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  TRIGGER [dbo].[tr_prescription_details_after_update]
ON dbo.prescription_details
AFTER UPDATE
AS
  DECLARE @presID AS INTEGER, @deliveryMethod AS INTEGER, @OldRefills AS INTEGER, @NewRefills AS INTEGER, @DRUGCLASS AS VARCHAR(1),@PRN AS bit,@OLDPRN AS bit,@usegeneric AS bit,@oldusegeneric AS bit,@responsetype As INTEGER,@bSigned AS BIT
  SELECT @presID = pres_id FROM inserted
  
  DECLARE @FldsUpdated XML
  DECLARE @ColumnsUpdated VARBINARY(100)	  
  SET @ColumnsUpdated = COLUMNS_UPDATED()
  /* Binary Bit Pattern 204|7|0|0|2 */
  IF ((SUBSTRING(@ColumnsUpdated, 1, 1) & 204 > 0) OR (substring(@ColumnsUpdated, 2,1) & 7 > 0) OR (Substring(@ColumnsUpdated,5,1)& 2 > 0))
  /* Interesting columns updated, check if the prescription was approved, if yes then trigger audit */
  BEGIN
   IF EXISTS (SELECT pres_id FROM prescriptions WHERE pres_id = @presID AND pres_approved_date IS NOT NULL  AND DATEDIFF(n,pres_approved_date, getdate()) > 2)
    Begin     
    SET @FldsUpdated = 
            (
                  SELECT COLUMN_NAME AS Name
                  FROM INFORMATION_SCHEMA.COLUMNS Field
                  WHERE 
                        TABLE_NAME = 'prescription_DETAILS' AND
                        sys.fn_IsBitSetInBitmask
                        (
                              @ColumnsUpdated, 
                  COLUMNPROPERTY(OBJECT_ID(TABLE_SCHEMA + '.' + TABLE_NAME), COLUMN_NAME, 'ColumnID')
                        ) <> 0 
                  FOR XML AUTO, ROOT('Fields')
            ) 

		 INSERT INTO table_audit_log
			  (table_name, dg_id, src_id, src_name, target_id, target_name,evt_date, sql_login, columns_updated)
			  SELECT 'prescription_details', p.dg_id, dr_id, dr_id, a.pres_id, a.pres_id,getdate(), system_user, @FldsUpdated
			  FROM INSERTED a inner join prescriptions p with(nolock) on a.pres_id = p.pres_id
   End
  END
  
  IF EXISTS (SELECT pres_id FROM prescriptions WHERE pres_id = @presID AND pres_prescription_type = 2 AND pres_approved_date IS NOT NULL)
  BEGIN
  SELECT @bSigned=case when is_signed is null then 0 else is_signed end FROM prescriptions WHERE pres_id = @presID
  SELECT @OldRefills = refills,@responsetype=response_type FROM  refill_requests WHERE pres_id=@presID
  SELECT @NewRefills = numb_refills,@PRN=PRN,@usegeneric=use_generic FROM inserted
  SELECT @OLDPRN = PRN,@oldusegeneric=use_generic FROM deleted  
  SELECT TOP 1 @DRUGCLASS = MED_REF_DEA_CD FROM inserted A INNER JOIN RMIID1 B ON A.ddid=B.MEDID
  If EXISTS (SELECT PH.pharm_id from prescriptions P inner join pharmacies PH on P.pharm_id=PH.pharm_id 
     where P.pres_id = @PRESID AND NOT(PH.SERVICE_LEVEL IS NULL) AND PH.SERVICE_LEVEL < 1024 )
     BEGIN
		SET @bSigned = 0
     END  
  IF (@DRUGCLASS > 1 AND @bSigned = 0)
  BEGIN
		If (@responsetype <> 0)
		BEGIN
		      UPDATE refill_requests SET response_type = 0,void_comments='This is a scheduled 3 - 5 drug, approval will be sent as fax' WHERE pres_id = @presID
		      SELECT @deliveryMethod = pres_delivery_method FROM prescriptions WHERE pres_id = @presID
		      /*EXEC insertPrescriptionVoidTransmittal @presID, @deliveryMethod*/
		END
		ELSE
		BEGIN
			UPDATE refill_requests SET response_type = 0 WHERE pres_id = @presID
			SELECT @deliveryMethod = pres_delivery_method FROM prescriptions WHERE pres_id = @presID
			EXEC insertPrescriptionVoidTransmittal @presID, @deliveryMethod
		END
  END
ELSE
    BEGIN
		
	    IF EXISTS (SELECT * FROM inserted A, deleted B WHERE A.ddid = B.ddid AND A.dosage = B.dosage AND A.duration_amount = B.duration_amount
	    AND A.duration_unit = B.duration_unit AND A.prn = B.prn AND A.comments=B.comments AND A.numb_refills=@OldRefills AND A.use_generic=@oldusegeneric And (A.refills_prn=B.refills_prn Or B.refills_prn IS NULL ))
		BEGIN
			UPDATE refill_requests SET response_type = CASE WHEN pres_void = 0 THEN 1 ELSE 0 END FROM refill_requests, prescriptions WHERE refill_requests.pres_id = @presID AND prescriptions.pres_id = @presID
		END
	    ELSE
		BEGIN
		/* APPROVE WITH CHANGES....
		IF THERE IS A CHANGE ONLY IN REFILLS FROM NON ZERO TO NON ZERO THEN SEND RESPONSE TYPE AS 100*/
		IF EXISTS (SELECT * FROM inserted A, deleted B WHERE A.ddid = B.ddid AND A.dosage = B.dosage AND A.duration_amount = B.duration_amount
	    AND A.duration_unit = B.duration_unit AND A.prn = B.prn AND A.comments=B.comments)
		AND ((NOT(@OldRefills IS NULL) AND @OldRefills > 0 AND @OldRefills <> @NewRefills) Or (@usegeneric <> @oldusegeneric)) 
		AND EXISTS(SELECT A.pharm_id FROM pharmacies A inner join refill_requests B on B.pres_id=@presID AND A.pharm_id=B.pharm_id WHERE (A.pharm_participant=262144 OR A.pharm_participant=262145))
			BEGIN
				UPDATE refill_requests SET response_type = 100 WHERE pres_id = @presID
			END
		ELSE IF EXISTS (SELECT * FROM inserted A, deleted B WHERE A.ddid = B.ddid AND A.dosage = B.dosage AND A.duration_amount = B.duration_amount
	    AND A.duration_unit = B.duration_unit AND A.prn = B.prn AND A.comments=B.comments AND A.use_generic=@oldusegeneric) AND ((NOT(@OldRefills IS NULL) AND @OldRefills = 0 AND @OldRefills <> @NewRefills)) 
		AND EXISTS(SELECT A.pharm_id FROM pharmacies A inner join refill_requests B on B.pres_id=@presID AND A.pharm_id=B.pharm_id WHERE (A.pharm_participant=262144 OR A.pharm_participant=262145))
			BEGIN
				UPDATE refill_requests SET response_type = CASE WHEN pres_void = 0 THEN 1 ELSE 0 END FROM refill_requests, prescriptions WHERE refill_requests.pres_id = @presID AND prescriptions.pres_id = @presID
			END
		ELSE IF EXISTS (SELECT * FROM inserted A, deleted B WHERE A.ddid = B.ddid AND A.dosage = B.dosage AND A.duration_amount = B.duration_amount
	    AND A.duration_unit = B.duration_unit AND A.prn = B.prn AND A.comments=B.comments AND A.use_generic=@oldusegeneric) AND ((NOT(@OldRefills IS NULL) AND @OldRefills = 0 AND @OldRefills <> @NewRefills)) 
		AND EXISTS(SELECT A.pharm_id FROM pharmacies A inner join refill_requests B on B.pres_id=@presID AND A.pharm_id=B.pharm_id WHERE (A.pharm_participant=65536))
			BEGIN
				UPDATE refill_requests SET response_type = 100 WHERE pres_id = @presID
			END
		ELSE
			BEGIN	
				UPDATE refill_requests SET response_type = 10 WHERE pres_id = @presID
				SELECT @deliveryMethod = pres_delivery_method FROM prescriptions WHERE pres_id = @presID
				EXEC insertPrescriptionVoidTransmittal @presID, @deliveryMethod		      
			 END
		END
 END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

DISABLE TRIGGER [dbo].[tr_prescription_details_after_update] ON [dbo].[prescription_details]
GO

GO
