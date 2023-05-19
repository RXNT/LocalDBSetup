SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to insert Lab Order Id Matching
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_InsertDeduplication_LabOrderIdMatching]
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
	WHERE	PST.Code = 'LBORD'

	-- First Transition table	
	
	Select	Distinct dg.dc_id, LM.lab_order_master_id As DuplicationText
	INTO	#TempPatients
	From	dbo.lab_main LM WITH (NOLOCK)
			INNER JOIN dbo.patients pat WITH (NOLOCK) on pat.pa_id = LM.pat_id
			INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
			INNER JOIN dbo.patient_lab_orders_master PLOM WITH (NOLOCK) on PLOM.lab_master_id = LM.lab_order_master_id
			INNER JOIN dbo.patients pat1 WITH (NOLOCK) on pat1.pa_id = PLOM.pa_id and pat1.dg_id > 0
			INNER JOIN dbo.doc_groups dg1 WITH (nolock) on dg1.dg_id = pat1.dg_id
															AND dg1.dc_id = @CompanyId
			INNER JOIN dbo.doc_companies CMP WITH (NOLOCK) ON CMP.dc_id = dg.dc_id
															AND CMP.dc_id = @CompanyId
	WHERE	LM.pat_id != PLOM.pa_id 
			AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
							FROM	@TempMerge.nodes('/que') as T(C)
							WHERE	T.C.value('@secondary_pa_id', 'bigint') = PLOM.pa_id)

	INSERT INTO rpt.DoctorCompanyDeduplicationTransition
	(DoctorCompanyDeduplicateRequestId, CompanyId, ProcessStatusTypeId, DuplicationTypeId, DuplicationText, Active, CreatedDate, CreatedBy)
	SELECT	@DoctorCompanyDeduplicateRequestId, @CompanyId, @ProcessPendingStatusId, @DuplicationTypeId, Convert(VARCHAR(1000), DuplicationText), 1, @CreatedDate, @CreatedBy
	FROM	#TempPatients
	
	INSERT INTO rpt.DoctorCompanyDeduplicationPatientTransition
	(DoctorCompanyDeduplicationTransitionId, CompanyId, DoctorGroupId, PatientId, ProcessStatusTypeId, Active, CreatedDate, CreatedBy)	
	Select  tmp.DoctorCompanyDeduplicationTransitionId, DG.dc_id, pre.dg_id, PRE.pat_id, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
	FROM	dbo.lab_main PRE WITH (NOLOCK) 
			INNER JOIN dbo.patients pat WITH (NOLOCK) on pat.pa_id = PRE.pat_id
			INNER JOIN  dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
			INNER JOIN rpt.DoctorCompanyDeduplicationTransition TMP WITH (NOLOCK) on Convert(BIGINT, TMP.DuplicationText) = PRE.lab_order_master_id 
																										AND tmp.CompanyId = @CompanyId
																										AND tmp.DuplicationTypeId = @DuplicationTypeId
																										AND tmp.ProcessStatusTypeId = @ProcessPendingStatusId
																											AND TMP.companyId = dg.dc_id
	Where	dg.dc_id = @CompanyId		
			AND tmp.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
			AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
						FROM	@TempMerge.nodes('/que') as T(C)
						WHERE	T.C.value('@secondary_pa_id', 'bigint') = pat.pa_id)
	Union
	Select  tmp.DoctorCompanyDeduplicationTransitionId, TMP.companyId, dc.dg_id, PRE.pa_id, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
	FROM	dbo.patient_lab_orders_master PRE WITH (NOLOCK) 
			INNER JOIN dbo.patients pat WITH (NOLOCK) on pat.pa_id = PRE.pa_id
			INNER JOIN dbo.doctors dc WITH (NOLOCK) on dc.dr_id = pat.dr_id
			INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on dg.dg_id = dc.dg_id
			INNER JOIN rpt.DoctorCompanyDeduplicationTransition TMP WITH (NOLOCK) on Convert(BIGINT, TMP.DuplicationText) = PRE.lab_master_id and tmp.companyId = dg.dc_id
																								AND tmp.CompanyId = @CompanyId
																								AND tmp.DuplicationTypeId = @DuplicationTypeId
																								AND tmp.ProcessStatusTypeId = @ProcessPendingStatusId
	Where	dg.dc_id = @CompanyId
			AND tmp.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
			
				AND not exists (Select	T.C.value('@secondary_pa_id', 'bigint') As secondary_pa_id
							FROM	@TempMerge.nodes('/que') as T(C)
							WHERE	T.C.value('@secondary_pa_id', 'bigint') = pat.pa_id)
		

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
