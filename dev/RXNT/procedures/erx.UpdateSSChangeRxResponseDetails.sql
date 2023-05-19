SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 20-SEP-2017
-- Description:	To update Change Rx response details
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[UpdateSSChangeRxResponseDetails]
	@ResponseType VARCHAR(10),
	@ResponseText VARCHAR(MAX),
	@TransmissionId BIGINT,
	@pdid BIGINT,
	@DeliveryMethod BIGINT,
	@IsDeniedRx BIT=0
AS

BEGIN
	IF(@IsDeniedRx=0)
	BEGIN
		UPDATE prescription_transmittals SET send_date = GETDATE(),response_date=GETDATE(),response_type=@ResponseType,response_text=@ResponseText WHERE pt_id = @TransmissionId
	END
	ELSE IF(@IsDeniedRx=1)
	BEGIN
		UPDATE erx.RxChangeVoidTransmittals SET SendDate=GETDATE(),ResponseDate=GETDATE(),ResponseType=@ResponseType,ResponseText=@ResponseText WHERE ChgVoidId=@TransmissionId
	END
	
	UPDATE prescription_status SET response_date=GETDATE(),response_type=@ResponseType,response_text=@ResponseText WHERE pd_id = @pdid AND delivery_method=@DeliveryMethod
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
