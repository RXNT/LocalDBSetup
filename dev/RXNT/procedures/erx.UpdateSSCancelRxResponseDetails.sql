SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To update cancel Rx response details
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[UpdateSSCancelRxResponseDetails]
	@ResponseType VARCHAR(10),
	@ResponseText VARCHAR(MAX),
	@TransmissionId BIGINT,
	@pdid BIGINT,
	@DeliveryMethod BIGINT
AS

BEGIN
	UPDATE prescription_Cancel_transmittals SET send_date = GETDATE(),response_date=GETDATE(),response_type=@ResponseType,response_text=@ResponseText WHERE pct_id = @TransmissionId
	
	UPDATE prescription_status SET response_date=GETDATE(),response_type=@ResponseType,response_text=@ResponseText WHERE pd_id = @pdid AND delivery_method=@DeliveryMethod
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
