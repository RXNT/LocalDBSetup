SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[insertDOTransmittal]
  @DOID INTEGER, @DODETAILSID INTEGER = 0, @ForceSend BIT = 0
AS
DECLARE @QueuedDate DATETIME

  SET @QueuedDate = GETDATE()
  IF @DODETAILSID > 0 AND EXISTS (SELECT rlt_id FROM rxntliberty_transmittals WHERE liberty_details_id = @DODETAILSID AND response_date IS NULL)
    BEGIN           
      IF @ForceSend <> 0
		BEGIN
			UPDATE rxntliberty_transmittals SET queued_date = @QueuedDate, send_date = NULL WHERE liberty_details_id = @DODETAILSID AND response_date IS NULL
		END
    END
  ELSE
    BEGIN
		IF @DODETAILSID > 0 
		BEGIN
			INSERT INTO rxntliberty_transmittals
			   ([liberty_details_id]
			   ,[send_date]
			   ,[response_date]
			   ,[response_type]
			   ,[response_text]
			   ,[queued_date]) VALUES(
			@DODETAILSID, NULL, NULL, NULL,NULL ,@QueuedDate)
			UPDATE rxntlibertydetails SET response_type = NULL, response_date = NULL, response_text = NULL
			WHERE liberty_details_id = @DODETAILSID				
		END
		ELSE IF (@DOID > 0)
		BEGIN
			DELETE FROM rxntliberty_transmittals WHERE liberty_details_id IN (select liberty_details_id from rxntlibertydetails where liberty_do_id =	@DOID) AND response_date IS NULL
			INSERT INTO rxntliberty_transmittals (liberty_details_id,queued_date) select liberty_details_id,GETDATE() from rxntlibertydetails where liberty_do_id =	@DOID
			UPDATE rxntlibertydetails SET response_type = NULL, response_date = NULL, response_text = NULL
			WHERE liberty_do_id =	@DOID				
		END
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
