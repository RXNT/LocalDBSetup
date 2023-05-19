SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE      TRIGGER [dbo].[tr_prescriptions_after_update]
ON [dbo].[prescriptions]
AFTER update
AS
  DECLARE @PRESID AS INTEGER,@DRUGCLASS AS varchar(1),@deliveryMethod AS INTEGER,@PRESTYPE AS INTEGER ,@PRESVOID AS  SMALLINT,@bSigned AS BIT
  DECLARE @Cinfo VARBINARY(128)  
  SELECT @Cinfo = Context_Info()  
  IF @Cinfo = 0x55555  RETURN  
  SELECT @PRESID = pres_id,@PRESTYPE=pres_prescription_type,@PRESVOID=pres_void FROM inserted
  IF (UPDATE(pres_void) OR UPDATE(pres_approved_date)) AND @PRESTYPE=2
    BEGIN
  SELECT TOP 1 @DRUGCLASS = MED_REF_DEA_CD,@bSigned=case when is_signed is null then 0 else is_signed end,@deliveryMethod=pres_delivery_method FROM inserted A INNER JOIN prescription_details B on A.pres_id=B.pres_id INNER JOIN RNMMIDNDC C ON B.ddid=C.MEDID
  If EXISTS (SELECT PH.pharm_id from prescriptions P inner join pharmacies PH on P.pharm_id=PH.pharm_id 
     where P.pres_id = @PRESID AND NOT(PH.SERVICE_LEVEL IS NULL) AND PH.SERVICE_LEVEL < 1024 )
     BEGIN
		SET @bSigned = 0
     END
  IF (@DRUGCLASS > 1 AND @bSigned=0)
  BEGIN
	IF (@PRESVOID<>1)
	BEGIN
	      UPDATE refill_requests SET response_type = 0,void_comments='This is a scheduled 3 - 5 drug, approval will be sent as fax' WHERE pres_id = @presID
	      SELECT @deliveryMethod = pres_delivery_method FROM prescriptions WHERE pres_id = @presID
	      /*EXEC insertPrescriptionVoidTransmittal @presID, @deliveryMethod*/
	END
	ELSE
	BEGIN
		UPDATE refill_requests SET response_type = 0,void_comments = prescriptions.pres_void_comments 
		FROM refill_requests, prescriptions WHERE prescriptions.pres_id = @PRESID AND refill_requests.pres_id = prescriptions.pres_id
	END
  END
ELSE
      BEGIN
      UPDATE refill_requests SET response_type = CASE WHEN response_type = 10 THEN 10 WHEN response_type=100 THEN 100
      WHEN pres_void = 0 THEN 1 ELSE 0 END,	void_comments = prescriptions.pres_void_comments, void_code = prescriptions.pres_void_code 
	FROM refill_requests, prescriptions WHERE prescriptions.pres_id = @PRESID AND refill_requests.pres_id = prescriptions.pres_id
 	END
    END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_prescriptions_after_update] ON [dbo].[prescriptions]
GO

GO
