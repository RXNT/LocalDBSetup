SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 30-Dec-2021
-- Description:	Move Cancelled EPA to Pending Rx
-- =============================================
CREATE PROCEDURE [eRx2019].[usp_MoveCancelledEPAToPendingRx] 
	@PatientId BIGINT,
	@PAReferenceId VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @RxId BIGINT
	DECLARE @RxDetailId BIGINT
	SELECT @RxId = det.pres_id, @RxDetailId = det.pd_id 
	FROM prescription_details det WITH(NOLOCK) 
	INNER JOIN prescriptions rx WITH(NOLOCK) ON rx.pres_id = det.pres_id
	WHERE rx.pa_id = @PatientId
	AND PAReferenceId = @PAReferenceId AND det.hide_on_pending_rx=1
	IF NOT(ISNULL(@RxId,0)>0 AND ISNULL(@RxDetailId,0)>0)
	BEGIN
		SELECT TOP 1 @PatientId = primary_pa_id 
		FROM [dbo].[Patient_merge_request_queue] WITH(NOLOCK)
		WHERE secondary_pa_id=@PatientId
		ORDER BY pa_merge_reqid DESC

		SELECT @RxId = det.pres_id, @RxDetailId = det.pd_id 
		FROM prescription_details det WITH(NOLOCK) 
		INNER JOIN prescriptions rx WITH(NOLOCK) ON rx.pres_id = det.pres_id
		WHERE rx.pa_id = @PatientId
		AND PAReferenceId = @PAReferenceId AND det.hide_on_pending_rx=1
	END
	IF ISNULL(@RxId,0)>0 AND ISNULL(@RxDetailId,0)>0
	BEGIN
		UPDATE prescription_details 
		SET hide_on_pending_rx=0,prior_authorization_status=NULL,prior_auth_number=NULL,PAReferenceId=NULL
		WHERE pd_id=@RxDetailId AND pres_id=@RxId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
