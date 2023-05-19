SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[insertPrescriptionCancelTransmittal]
  @PRESID INTEGER,@PDID INTEGER =0, @PharmID INTEGER =0
  AS
		DECLARE @QueuedDate DATETIME
		DECLARE @PHARMPART INTEGER
		
		SET @QueuedDate = GETDATE()
		SET @PHARMPART = 0
		SELECT @PharmID=pharm_id,@PDID=pd_id from prescriptions A WITH(NOLOCK) INNER JOIN prescription_details B WITH(NOLOCK) on A.pres_id=B.pres_id where A.pres_id=@PRESID
		IF EXISTS(SELECT pharm_id from pharmacies where pharm_id=@PharmID AND pharm_participant > 2 AND ((service_level & 16 = 16)))
		BEGIN
			SELECT @PHARMPART=pharm_participant from pharmacies where pharm_id=@PharmID
			IF EXISTS(SELECT PD_ID FROM PRESCRIPTION_STATUS WHERE PD_ID=@PDID AND DELIVERY_METHOD=@PHARMPART) 
			BEGIN
				UPDATE prescription_details SET CANCEL_STATUS=2,CANCEL_STATUS_TEXT='' WHERE pres_id = @PRESID
				UPDATE prescription_status SET RESPONSE_TYPE=NULL, RESPONSE_TEXT='', RESPONSE_DATE=NULL, cancel_req_response_date=NULL, cancel_req_response_type=NULL, cancel_req_response_text='' WHERE pd_id=@PDID
				IF NOT EXISTS (SELECT pct_id FROM prescription_cancel_transmittals WHERE pres_id = @PRESID)
				BEGIN
					insert into prescription_Cancel_transmittals(pd_id,pres_id,delivery_method,response_type,response_text,send_date,response_date,queued_date)
					values(@PDID,@PRESID,@PHARMPART,NULL,NULL,NULL,NULL,GETDATE())
				END
				--ELSE
				--BEGIN
				--	UPDATE prescription_Cancel_transmittals SET send_date=NULL, response_date=NULL,queued_date=GETDATE() WHERE pres_id=@PRESID AND pd_id=@PDID
				--END
			END
		END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
