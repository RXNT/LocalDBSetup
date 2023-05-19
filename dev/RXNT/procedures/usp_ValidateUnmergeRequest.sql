SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ValidateUnmergeRequest]
(	
	@CompanyId BIGINT,
	@MergeRequestBatchId BIGINT,
	@ErrorExists AS BIT OUTPUT,
	@ErrorMessage AS VARCHAR(8000) OUTPUT
)
AS
BEGIN
	SET @ErrorExists = 0
	SET @ErrorMessage = ''
	
	DECLARE @TempPatients AS TABLE (PatientId BIGINT, CreatedDate DateTime)

	INSERT INTO @TempPatients
	Select	Distinct QUE.primary_pa_id, BAT.created_date
	From	dbo.Patient_merge_request_batch BAT WITH (NOLOCK)
			INNER JOIN dbo.Patient_merge_request_queue QUE WITH (NOLOCK) ON QUE.pa_merge_batchid = BAT.pa_merge_batchid
	Where	BAT.pa_merge_batchid = @MergeRequestBatchId and BAT.dc_id = @CompanyId

	INSERT INTO @TempPatients
	Select	QUE.secondary_pa_id, BAT.created_date
	From	dbo.Patient_merge_request_batch BAT WITH (NOLOCK)
			INNER JOIN dbo.Patient_merge_request_queue QUE WITH (NOLOCK) ON QUE.pa_merge_batchid = BAT.pa_merge_batchid
	Where	BAT.pa_merge_batchid = @MergeRequestBatchId and BAT.dc_id = @CompanyId

	IF EXISTS(
		Select	NULL
		From	@TempPatients PAT 
				INNER JOIN dbo.Patient_merge_request_queue QUE WITH (NOLOCK) ON QUE.secondary_pa_id = PAT.PatientId
				INNER JOIN dbo.Patient_merge_request_batch BAT WITH (NOLOCK) ON BAT.pa_merge_batchid = QUE.pa_merge_batchid
		WHERE	BAT.dc_id = @CompanyId AND BAT.created_date >= PAT.CreatedDate AND BAT.pa_merge_batchid != @MergeRequestBatchId AND QUE.status Not In (5,6))
	BEGIN

		DECLARE @PatientIds AS VARCHAR(2000)
		SET @PatientIds = ''

		Select @PatientIds = (
		Select	CONVERT(VARCHAR(50), PAT.PatientId) + ',' AS [text()]
		From	@TempPatients PAT 
				INNER JOIN dbo.Patient_merge_request_queue QUE WITH (NOLOCK) ON QUE.secondary_pa_id = PAT.PatientId
				INNER JOIN dbo.Patient_merge_request_batch BAT WITH (NOLOCK) ON BAT.pa_merge_batchid = QUE.pa_merge_batchid
		WHERE	BAT.dc_id = @CompanyId AND BAT.created_date >= PAT.CreatedDate AND BAT.pa_merge_batchid != @MergeRequestBatchId AND QUE.status Not In (5,6)
		For XML PATH ('')
		)
		SET @ErrorExists = 1
		SET @ErrorMessage = @ErrorMessage + ' Exists a recent merge for the Patients ' + @PatientIds  + ' involved in this merge. Please unmerge them first \n'
	END

	IF @ErrorExists = 0 AND EXISTS(
		SELECT	NULL
		FROM	dbo.PatientUnmergeRequests UNM WITH (NOLOCK)
				INNER JOIN dbo.Patient_merge_status STS WITH (NOLOCK) ON STS.StatusId = UNM.StatusId AND STS.Status = 'Pending'
		WHERE	UNM.Active = 1 AND UNM.CompanyId = @CompanyId AND UNM.pa_merge_batchid = @MergeRequestBatchId)
	BEGIN
		SET @ErrorExists = 1
		SET @ErrorMessage = @ErrorMessage + ' Already pending unmerge request exists for this batch \n'
	END
	IF  @ErrorExists = 0 AND NOT EXISTS(
		SELECT	NULL
		FROM	bk.patients UNM WITH (NOLOCK)
				INNER JOIN dbo.Patient_merge_request_queue QUE WITH (NOLOCK) ON QUE.pa_merge_reqid = UNM.pa_merge_reqid
		WHERE	QUE.pa_merge_batchid = @MergeRequestBatchId)
	BEGIN
		SET @ErrorExists = 1
		SET @ErrorMessage = @ErrorMessage + ' Can''t create unmerge request for this merge request \n'
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
