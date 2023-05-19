SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[VoidPrescriptionDischargeRequest]
	@DischargeRequestId 	int,
	@UserId 				BIGINT,
	@VoidedReason 			VARCHAR(255)
AS
BEGIN 
	UPDATE prescription_discharge_requests 
	SET is_active = 0,last_modified_by = @UserId,last_modified_on = GETDATE(),voided_reason = @VoidedReason 
	WHERE discharge_request_id = @DischargeRequestId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
