SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to insert Patients Deduplications
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_InsertDeduplicationPatients]
(
	@CompanyId BIGINT,
	@DoctorCompanyDeduplicateRequestId BIGINT
)
AS
BEGIN

	
	DECLARE @errorMsg NVARCHAR(4000),
			@errorSeverity INT,
			@errorState INT;
	BEGIN TRY
		BEGIN TRAN
		SET NOCOUNT ON;	

		DECLARE @ProcessCancelStatusId AS BIGINT
		DECLARE @ProcessPendingStatusId AS BIGINT
		DECLARE @CreatedDate AS DATETIME
		DECLARE @CreatedBy AS BIGINT

		SET @CreatedBy = 1
		SET @CreatedDate = GETDATE()

		SELECT	@ProcessCancelStatusId = ProcessStatusTypeId
		FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
		WHERE	PST.Code = 'CANCL'

		SELECT	@ProcessPendingStatusId = ProcessStatusTypeId
		FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
		WHERE	PST.Code = 'PENDG'

		/*Cancel all the pending records related to the company*/
		UPDATE	rpt.DoctorCompanyDeduplicationTransition
		SET		ProcessStatusTypeId = @ProcessCancelStatusId,
				ProcessStartDate = @CreatedDate,
				ProcessEndDate = @CreatedDate,
				ProcessStatusMessage = 'Cancelling the pending transitions since of deduplication rerun for the company',
				ModifiedBy = @CreatedBy,
				ModifiedDate = @CreatedDate
		WHERE	CompanyId = @CompanyId
				AND ProcessStatusTypeId = @ProcessPendingStatusId
			
		UPDATE	rpt.DoctorCompanyDeduplicationPatientTransition
		SET		ProcessStatusTypeId = @ProcessCancelStatusId,
				ProcessStartDate = @CreatedDate,
				ProcessEndDate = @CreatedDate,
				ProcessStatusMessage = 'Cancelling the pending transitions since of deduplication rerun for the company',
				ModifiedBy = @CreatedBy,
				ModifiedDate = @CreatedDate
		WHERE	CompanyId = @CompanyId
				AND ProcessStatusTypeId = @ProcessPendingStatusId

		UPDATE	rpt.DeduplicationPrimaryPatientTransition
		SET		ProcessStatusTypeId = @ProcessCancelStatusId,
				ProcessStartDate = @CreatedDate,
				ProcessEndDate = @CreatedDate,
				ProcessStatusMessage = 'Cancelling the pending transitions since of deduplication rerun for the company',
				ModifiedBy = @CreatedBy,
				ModifiedDate = @CreatedDate
		WHERE	CompanyId = @CompanyId
				AND ProcessStatusTypeId = @ProcessPendingStatusId

		UPDATE	rpt.DeduplicationPatientGroups
		SET		ProcessStatusTypeId = @ProcessCancelStatusId,
				ProcessStartDate = @CreatedDate,
				ProcessEndDate = @CreatedDate,
				ProcessStatusMessage = 'Cancelling the pending transitions since of deduplication rerun for the company',
				ModifiedBy = @CreatedBy,
				ModifiedDate = @CreatedDate
		WHERE	CompanyId = @CompanyId
				AND ProcessStatusTypeId = @ProcessPendingStatusId

		UPDATE	rpt.DeduplicationPatients
		SET		ProcessStatusTypeId = @ProcessCancelStatusId,
				ProcessStartDate = @CreatedDate,
				ProcessEndDate = @CreatedDate,
				ProcessStatusMessage = 'Cancelling the pending transitions since of deduplication rerun for the company',
				ModifiedBy = @CreatedBy,
				ModifiedDate = @CreatedDate
		WHERE	CompanyId = @CompanyId
				AND ProcessStatusTypeId = @ProcessPendingStatusId

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
