SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_UpdatePatientIntakeSyncStatus]
	 
	@PatientId			BIGINT,
	@IsPatientIntakeSyncReviewPending			BIT
 
AS
BEGIN
	UPDATE	patient_extended_details
		SET		is_patient_intake_sync_review_pending = @IsPatientIntakeSyncReviewPending			
		WHERE	pa_id = @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
