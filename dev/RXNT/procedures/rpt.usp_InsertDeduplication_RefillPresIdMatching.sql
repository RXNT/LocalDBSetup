SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to insert Refill Request Prescription Id Matching
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_InsertDeduplication_RefillPresIdMatching]
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
	WHERE	PST.Code = 'RPRID'

	-- First Transition table	
	
	SELECT	Distinct dg.dc_id, RRQ.dg_id,
			RRQ.fullRequestMessage.value('(Message/Header/PrescriberOrderNumber)[1]','decimal(38,0)') AS PrescriberOrderNumber,
			RRQ.pa_id
	INTO	#TempRefill
	FROM	dbo.refill_requests RRQ WITH (NOLOCK)
			INNER JOIN  dbo.doc_groups RRQDG WITH (NOLOCK) on RRQDG.dg_id = RRQ.dg_id
			INNER JOIN dbo.patients pat WITH (NOLOCK) on pat.pa_id = RRQ.pa_id
			INNER JOIN  dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
	Where	dg.dc_id = @CompanyId AND RRQDG.dc_id = @CompanyId 
			AND RRQ.fullRequestMessage IS NOT NULL
			AND ISNULL(RRQ.fullRequestMessage.value('(Message/Header/PrescriberOrderNumber)[1]','NVARCHAR(500)'), '') NOT LIKE '%[^0-9]%'

	SELECT	Distinct RRQ.dc_id,
			CONVERT(VARCHAR(500), RRQ.PrescriberOrderNumber) AS DuplicationText
	INTO	#TempPatients
	FROM	#TempRefill RRQ WITH (NOLOCK)
			INNER JOIN  dbo.prescriptions PRE WITH (NOLOCK) on PRE.pres_id =  RRQ.PrescriberOrderNumber
			INNER JOIN  dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = PRE.dg_id
	Where	RRQ.pa_id != PRE.pa_id and RRQ.pa_id > 0 and PRE.pa_id > 0
			AND RRQ.dc_id = @CompanyId	AND DG.dc_id = @CompanyId
			AND RRQ.PrescriberOrderNumber IS NOT NULL
			AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
							FROM	@TempMerge.nodes('/que') as T(C)
							WHERE	T.C.value('@secondary_pa_id', 'bigint') = RRQ.pa_id)

	INSERT INTO rpt.DoctorCompanyDeduplicationTransition
	(DoctorCompanyDeduplicateRequestId, CompanyId, ProcessStatusTypeId, DuplicationTypeId, DuplicationText, Active, CreatedDate, CreatedBy)
	SELECT	@DoctorCompanyDeduplicateRequestId, @CompanyId, @ProcessPendingStatusId, @DuplicationTypeId, DuplicationText, 1, @CreatedDate, @CreatedBy
	FROM	#TempPatients
	
	INSERT INTO rpt.DoctorCompanyDeduplicationPatientTransition
	(DoctorCompanyDeduplicationTransitionId, CompanyId, DoctorGroupId, PatientId, ProcessStatusTypeId, Active, CreatedDate, CreatedBy)
	Select  tmp.DoctorCompanyDeduplicationTransitionId, DG.dc_id, pre.dg_id, PRE.pa_id, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
	FROM	dbo.prescriptions PRE WITH (NOLOCK) 
			INNER JOIN dbo.patients pat WITH (NOLOCK) on pat.pa_id = PRE.pa_id
			INNER JOIN  dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
			INNER JOIN rpt.DoctorCompanyDeduplicationTransition TMP WITH (NOLOCK) on TMP.DuplicationText = PRE.pres_id AND TMP.CompanyId = dg.dc_id
																				AND tmp.CompanyId = @CompanyId
																				AND tmp.DuplicationTypeId = @DuplicationTypeId
																				AND tmp.ProcessStatusTypeId = @ProcessPendingStatusId
	Where	dg.dc_id = @CompanyId
				AND tmp.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
				AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
							FROM	@TempMerge.nodes('/que') as T(C)
							WHERE	T.C.value('@secondary_pa_id', 'bigint') = PRE.pa_id)
	Union		
	Select  tmp.DoctorCompanyDeduplicationTransitionId, PRE.dc_id, PRE.dg_id, PRE.pa_id, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
	FROM	#TempRefill PRE WITH (NOLOCK) 
			INNER JOIN rpt.DoctorCompanyDeduplicationTransition TMP WITH (NOLOCK) on TMP.DuplicationText = PRE.PrescriberOrderNumber
																				AND TMP.CompanyId = PRE.dc_id
																				AND tmp.CompanyId = @CompanyId
																				AND tmp.DuplicationTypeId = @DuplicationTypeId
																				AND tmp.ProcessStatusTypeId = @ProcessPendingStatusId
	Where	PRE.dc_id = @CompanyId
			AND PRE.PrescriberOrderNumber IS NOT NULL
				AND tmp.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
				AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
							FROM	@TempMerge.nodes('/que') as T(C)
							WHERE	T.C.value('@secondary_pa_id', 'bigint') = PRE.pa_id)
		
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
