SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [ehr].[usp_InsertReferralTransmittal]
  @REFID INTEGER, @DeliveryMethod INTEGER  = 1, @ForceSend BIT = 0
AS
DECLARE @QueuedDate DATETIME
  SET @QueuedDate = GETDATE()
  IF EXISTS (SELECT referral_transmit_id FROM referral_transmittals WHERE referral_id = @REFID AND delivery_method = @DeliveryMethod AND response_date IS NULL)
    BEGIN           
      IF @ForceSend <> 0
		BEGIN
			UPDATE referral_transmittals SET queued_date = @QueuedDate, send_date = NULL WHERE referral_id = @REFID AND delivery_method = @DeliveryMethod AND response_date IS NULL
		END
    END
  ELSE
    BEGIN
        INSERT INTO [dbo].[referral_transmittals]
           ([referral_id]
           ,[send_date]
           ,[response_date]
           ,[response_type]
           ,[response_text]
           ,[delivery_method]
           ,[queued_date]) VALUES(
		@REFID, NULL, NULL, NULL,NULL , @DeliveryMethod,@QueuedDate)
	END
	IF EXISTS (SELECT referral_id FROM referral_status WHERE referral_id = @REFID AND delivery_method = @DeliveryMethod)
	BEGIN
	  UPDATE referral_status SET queued_date = @QueuedDate, response_type = NULL, response_date = NULL, response_text = NULL, confirmation_id = NULL
		FROM referral_status WHERE referral_id = @REFID AND delivery_method = @DeliveryMethod
	END
	ELSE 
	BEGIN
		INSERT INTO [dbo].[referral_status]
			   ([referral_id]
			   ,[delivery_method]
			   ,[response_type]
			   ,[response_text]
			   ,[response_date]
			   ,[confirmation_id]
			   ,[queued_date])
		 VALUES (@REFID,@DeliveryMethod,NULL,NULL,NULL,NULL,@QueuedDate)
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
