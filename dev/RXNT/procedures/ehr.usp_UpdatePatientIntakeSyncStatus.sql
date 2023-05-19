SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 09-Jul-2020
-- Description:	To update the status of Patient Intake Sync process
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpdatePatientIntakeSyncStatus]
	 
	@PatientId			BIGINT,
	@PatientIntakeSyncReviewStatus			BIT
 
AS

BEGIN
	Update	patient_extended_details
	Set		is_patient_intake_sync_review_pending = @PatientIntakeSyncReviewStatus			
	Where	pa_id = @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
