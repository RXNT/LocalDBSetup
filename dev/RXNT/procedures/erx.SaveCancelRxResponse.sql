SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To save cancel Rx response details
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[SaveCancelRxResponse]
	@ResponseType VARCHAR(10),
	@ResponseText VARCHAR(MAX),
	@TransmissionId BIGINT,
	@DeliveryMethod BIGINT
AS

BEGIN
	DECLARE @pdid AS BIGINT
	SET @pdid=0
	
	DECLARE @pres_id AS BIGINT
	SET @pres_id=0
	
	SELECT @pres_id=pres_id,@pdid=pd_id FROM prescription_Cancel_transmittals WITH(NOLOCK) WHERE pct_id=@TransmissionId
	
	UPDATE prescription_details SET cancel_status=@ResponseType, cancel_status_text=@ResponseText WHERE pd_id=@pdid
	
	UPDATE prescription_Cancel_transmittals SET response_date=GETDATE(),response_type=@ResponseType,response_text=@ResponseText WHERE pct_id = @TransmissionId
	
	UPDATE prescription_status SET cancel_req_response_date=GETDATE(),cancel_req_response_type=@ResponseType,cancel_req_response_text=@ResponseText WHERE pd_id = @pdid AND delivery_method=@DeliveryMethod
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
