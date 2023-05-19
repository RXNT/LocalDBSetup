SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to insert First Name Last Name Gender DOB Matching
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_InsertDeduplication_FnLnGenDOBMatching]
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
	WHERE	PST.Code = 'FLGDM'

	-- First Transition table	
	Select		dg.dc_id, 
				ISNULL(pat.pa_first, '') + '~~' + ISNULL(pat.pa_last, '') + '~~' + 
				ISNULL(pat.pa_sex, '')  + '~~' + 
				CONVERT(VARCHAR(50), CASE WHEN pat.pa_dob is null then '1901-01-01 00:00:00' ELSE pat.pa_dob END, 101) As DuplicationText
	INTO		#TempPatients
	From		dbo.Patients pat WITH (NOLOCK)
				INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
	WHERE		dg.dc_id = @CompanyId
				AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
								FROM	@TempMerge.nodes('/que') as T(C)
								WHERE	T.C.value('@secondary_pa_id', 'bigint') = pat.pa_id)
	Group By	dg.dc_id, 
				ISNULL(pat.pa_first, '') + '~~' + ISNULL(pat.pa_last, '') + '~~' + 
				ISNULL(pat.pa_sex, '')  + '~~' + 
				CONVERT(VARCHAR(50), CASE WHEN pat.pa_dob is null then '1901-01-01 00:00:00' ELSE pat.pa_dob END, 101)
	Having COUNT(*) > 1

	INSERT INTO rpt.DoctorCompanyDeduplicationTransition
	(DoctorCompanyDeduplicateRequestId, CompanyId, ProcessStatusTypeId, DuplicationTypeId, DuplicationText, Active, CreatedDate, CreatedBy)
	SELECT	@DoctorCompanyDeduplicateRequestId, @CompanyId, @ProcessPendingStatusId, @DuplicationTypeId, DuplicationText, 1, @CreatedDate, @CreatedBy
	FROM	#TempPatients

	--Second Transition Table pa_id
	INSERT INTO rpt.DoctorCompanyDeduplicationPatientTransition
	(DoctorCompanyDeduplicationTransitionId, CompanyId, DoctorGroupId, PatientId, ProcessStatusTypeId, Active, CreatedDate, CreatedBy)
	Select		tmp.DoctorCompanyDeduplicationTransitionId, dg.dc_id, pat.dg_id, pat.pa_id, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
	FROM		dbo.patients pat WITH (NOLOCK)
				INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
				INNER JOIN rpt.DoctorCompanyDeduplicationTransition tmp WITH (NOLOCK) ON tmp.CompanyId = dg.dc_id 
																						AND tmp.CompanyId = @CompanyId
																						AND tmp.DuplicationTypeId = @DuplicationTypeId
																						AND tmp.ProcessStatusTypeId = @ProcessPendingStatusId
					AND ISNULL(pat.pa_first, '') + '~~' + ISNULL(pat.pa_last, '') + '~~' +  ISNULL(pat.pa_sex, '')  + '~~' + 						
						CONVERT(VARCHAR(50), CASE WHEN pat.pa_dob is null then '1901-01-01 00:00:00' ELSE pat.pa_dob END, 101)= tmp.DuplicationText
	WHERE		dg.dc_id = @CompanyId
				AND tmp.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId				
				AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
							FROM	@TempMerge.nodes('/que') as T(C)
							WHERE	T.C.value('@secondary_pa_id', 'bigint') = pat.pa_id)
	Order by	tmp.DoctorCompanyDeduplicationTransitionId, pat.pa_id
		

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
