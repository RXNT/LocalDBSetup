SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to reactivate primary patients which are deactivated wrongly
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_ReactivateMergedPrimaryPatients]
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

	DECLARE @ProcessSuccessStatusId AS BIGINT
	DECLARE @CurrentDate AS DATETIME2
	DECLARE @CreatedBy As BIGINT

	SET @CurrentDate = GETDATE()
	SET @CreatedBy = 1

	BEGIN TRY
	BEGIN TRAN
	
		IF NOT EXISTS(
		SELECT	NULL 
		FROM	[rpt].[ReactivateMergedPrimaryPatientsStatuses]
		WHERE	CompanyId = @CompanyId 
				AND Active = 1)
		BEGIN
		
			Select	distinct dg.dc_id, pat.pa_id, dg.dg_id
			INTO	#TempPrimaryPatients
			From	dbo.Patient_merge_request_queue PMRQ WITH (NOLOCK)
					INNER JOIN dbo.patients pat WITH (NOLOCK) ON pat.pa_id = PMRQ.primary_pa_id
					INNER JOIN dbo.doc_groups dg WITH (NOLOCK) ON dg.dg_id = -1 * pat.dg_id
					LEFT JOIN dbo.Patient_merge_request_queue PMRQ1 WITH (NOLOCK) ON PMRQ1.secondary_pa_id = PMRQ.primary_pa_id
			Where	pat.dg_id < 0 and dg.dc_id = @CompanyId
					AND PMRQ1.primary_pa_id IS NULL

			Update	pat
			SET		pat.dg_id = CASE WHEN pat.dg_id < 0 THEN -1 * pat.dg_id ELSE pat.dg_id END,
					pat.dr_id = CASE WHEN pat.dr_id < 0 THEN -1 * pat.dr_id ELSE pat.dr_id END
			FROM	#TempPrimaryPatients PTU 
					INNER JOIN dbo.patients pat WITH (NOLOCK) ON pat.pa_id = PTU.pa_id 
					INNER JOIN dbo.doc_groups DG WITH (NOLOCK) ON DG.dg_id = -1 * pat.dg_id
			WHERE	pat.dg_id < 0 AND DG.dc_id = @CompanyId
	
			SELECT	@ProcessSuccessStatusId = ProcessStatusTypeId
			FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
			WHERE	PST.Code = 'SUCES'

			INSERT INTO [rpt].[ReactivateMergedPrimaryPatientsStatuses]
			(DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, ProcessStatusTypeId, ProcessStartDate, ProcessEndDate, ProcessStatusMessage, Active, CreatedDate, CreatedBy)
			SELECT	@DoctorCompanyDeduplicateRequestId, @CompanyId, pa_id, @ProcessSuccessStatusId, @CurrentDate, @CurrentDate, 'Processed Successfully', 1, @CurrentDate, @CreatedBy
			FROM	#TempPrimaryPatients

			COMMIT TRAN
		END
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
