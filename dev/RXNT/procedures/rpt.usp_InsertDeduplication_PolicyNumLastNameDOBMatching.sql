SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to insert Insurance Policy Number LastName DOB Matching
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_InsertDeduplication_PolicyNumLastNameDOBMatching]
(
	@CompanyId BIGINT,
	@DoctorCompanyDeduplicateRequestId BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @errorMsg NVARCHAR(4000),
			@errorSeverity INT,
			@errorState INT;
	BEGIN TRY
		BEGIN TRAN
		DECLARE @TempMerge XML  
		SET @TempMerge =  
		(
		  Select	secondary_pa_id 
			FROM	dbo.Patient_merge_request_batch bat WITH (NOLOCK)
					INNER JOIN dbo.Patient_merge_request_queue que WITH (NOLOCK) ON que.pa_merge_batchid = bat.pa_merge_batchid
					INNER JOIN dbo.Patient_merge_status batsta with (nolock) on batsta.statusid = bat.status and Lower(batsta.status) = 'pending'
					INNER JOIN dbo.Patient_merge_status questa with (nolock) on questa.statusid = que.status and Lower(questa.status) = 'pending'
			WHERE	bat.dc_id = @CompanyId 
					and que.active = 1 
					and bat.active = 1
		  FOR XML AUTO, TYPE

		)
	DECLARE @ProcessPendingStatusId AS BIGINT
	DECLARE	@DuplicationTypeId AS BIGINT
	DECLARE @CreatedDate AS DATETIME2
	DECLARE @CreatedBy AS BIGINT

	SET @CreatedBy = 1
	SET @CreatedDate = GETDATE()

	SELECT	@ProcessPendingStatusId = ProcessStatusTypeId
	FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
	WHERE	PST.Code = 'PENDG'

	SELECT	@DuplicationTypeId = DuplicationTypeId
	FROM	rpt.DuplicationTypes PST WITH (NOLOCK)
	WHERE	PST.Code = 'INPLN'

	-- First Transition table	
	SELECT  Distinct PEAM.ExternalPatientId,
			ISNULL(pat.pa_last, '') As LastName,
			MCP.PolicyNumber As PolicyNumber,
			pat.pa_dob,
			MCP.PolicyNumber + '~~' + ISNULL(pat.pa_last, '') + '~~' + CONVERT(VARCHAR(50), 
			CASE WHEN pat.pa_dob is null then '1901-01-01 00:00:00' ELSE pat.pa_dob END, 101) as DuplicationText
			,pat.dg_id, pat.pa_id
	INTO	#TempPolicyNumbers
	FROM	dbo.Patients pat WITH (NOLOCK)
			INNER JOIN doc_groups DG with(nolock) on pat.dg_id = DG.dg_id and DG.dc_id = @CompanyId
			INNER JOIN [dbo].[RsynMasterPatientExternalAppMaps] PEAM WITH (NOLOCK) ON PEAM.ExternalPatientId = pat.pa_id
			INNER JOIN [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH (NOLOCK) on CEAM.CompanyId = PEAM.CompanyId
			INNER JOIN [dbo].[RsynMasterApplications] aPP WITH (NOLOCK) on APP.ApplicationId = CEAM.ExternalAppId
																		AND APP.Code = 'EHRAP'
			INNER JOIN [dbo].[RsynMasterCases] MC WITH (NOLOCK) on MC.PatientId = PEAM.PatientId 
			INNER JOIN [dbo].[RsynMasterCasePayers] MCP WITH (NOLock) on MCP.CaseId = MC.CaseId
	WHERE	CEAM.ExternalCompanyId = 	@CompanyId
			AND MC.Active = 1
			AND MCP.Active = 1
			AND MCP.PayerExpired = 0

	SELECT	dg.dc_id,  ISNULL(PEAM.PolicyNumber, '')  + '~~'  + ISNULL(PEAM.LastName, '') 
			+ '~~' + CONVERT(VARCHAR(50), 
			CASE WHEN PEAM.pa_dob is null then '1901-01-01 00:00:00' ELSE PEAM.pa_dob END, 101) As DuplicationText, COUNT(*) As Cnt
	INTO	#TempPatients
	FROM	dbo.patients pat WITH (NOLOCK)
			INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
			INNER JOIN #TempPolicyNumbers PEAM WITH (NOLOCK) on PEAM.ExternalPatientId = pat.pa_id
	WHERE	 dg.dc_id = @CompanyId
			AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
							FROM	@TempMerge.nodes('/que') as T(C)
							WHERE	T.C.value('@secondary_pa_id', 'bigint') = pat.pa_id)
	Group By dg.dc_id,   ISNULL(PEAM.PolicyNumber, '') + '~~' + ISNULL(PEAM.LastName, '') + '~~' + CONVERT(VARCHAR(50), CASE WHEN PEAM.pa_dob is null then '1901-01-01 00:00:00' ELSE PEAM.pa_dob END, 101)
	having COUNT(*) > 1

	INSERT INTO rpt.DoctorCompanyDeduplicationTransition
	(DoctorCompanyDeduplicateRequestId, CompanyId, ProcessStatusTypeId, DuplicationTypeId, DuplicationText, Active, CreatedDate, CreatedBy)
	SELECT	@DoctorCompanyDeduplicateRequestId, @CompanyId, @ProcessPendingStatusId, @DuplicationTypeId, tp.DuplicationText, 1, @CreatedDate, @CreatedBy
	FROM	#TempPatients as tp

	--Second Transition Table pa_id
	INSERT INTO rpt.DoctorCompanyDeduplicationPatientTransition
	(DoctorCompanyDeduplicationTransitionId, CompanyId, DoctorGroupId, PatientId, ProcessStatusTypeId, Active, CreatedDate, CreatedBy)
		Select		tmp.DoctorCompanyDeduplicationTransitionId, @CompanyId, MCP.dg_id, MCP.pa_id, 
				@ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
	FROM		rpt.DoctorCompanyDeduplicationTransition tmp WITH (NOLOCK)  
				INNER JOIN #TempPolicyNumbers MCP WITH (NOLOCK) 
				ON MCP.DuplicationText = tmp.DuplicationText
					AND tmp.CompanyId = @CompanyId
					AND tmp.DuplicationTypeId = @DuplicationTypeId
					AND tmp.ProcessStatusTypeId = @ProcessPendingStatusId
	WHERE		tmp.CompanyId = @CompanyId
				AND tmp.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
				AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
							FROM	@TempMerge.nodes('/que') as T(C)
							WHERE	T.C.value('@secondary_pa_id', 'bigint') = MCP.pa_id)
	Order by	tmp.DoctorCompanyDeduplicationTransitionId, MCP.pa_id
		
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SET @errorMsg =  'Error Procedure:' + ERROR_PROCEDURE() + ',  ' 
		+ 'Error Line:' + CAST(ERROR_LINE() AS VARCHAR(50)) + ',  '
		+ 'Error Message:' + ERROR_MESSAGE()
		SET @errorSeverity = ERROR_SEVERITY();
		SET @errorState = ERROR_STATE();
		RAISERROR (@errorMsg, @errorSeverity, @errorState);
		ROLLBACK TRAN
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
