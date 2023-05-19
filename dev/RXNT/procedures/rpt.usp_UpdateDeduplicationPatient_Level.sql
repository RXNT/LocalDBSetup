SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to update Deduplication Patient Is Primary
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_UpdateDeduplicationPatient_Level]
(
	@CompanyId							BIGINT,
	@DoctorCompanyDeduplicateRequestId	BIGINT,
	@DeduplicationPatientIds			XML,
	@LoggedInUserId						BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;	
	DECLARE @CreatedDate AS DATETIME
	DECLARE @CreatedBy AS BIGINT
	DECLARE @ProcessPendingStatusId AS BIGINT
	
	SET @CreatedDate = GETDATE()

	IF ISNULL(@LoggedInUserId,0)<=0
	BEGIN
		SET @CreatedBy = 1
	END
	ELSE
	BEGIN
		SET @CreatedBy = @LoggedInUserId
	END
	
	SELECT	@ProcessPendingStatusId = ProcessStatusTypeId
	FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
	WHERE	PST.Code = 'PENDG'
	
	UPDATE	DSP
	SET		DSP.Level = A.S.value('(Level)[1]', 'INT'),
			DSP.IncludePatientForMerge = CASE WHEN (ISNULL(DSP.IncludeWarningPatient, 0) = 1 AND DT.IsWarning = 1) 
											OR (DT.IsWarning = 0) OR (A.S.value('(Level)[1]', 'INT') = 1) THEN 1 ELSE 0 END,
			DSP.ModifiedBy = @CreatedBy,
			DSP.ModifiedDate = @CreatedDate
	FROM	rpt.DeduplicationPatients DSP
			INNER JOIN @DeduplicationPatientIds.nodes('ArrayOfDeduplicationPatient/DeduplicationPatient') A(S) ON A.S.value('(DeduplicationPatientId)[1]', 'BIGINT') = DSP.DeduplicationPatientId
			INNER JOIN rpt.DuplicationTypes DT WITH (nolock) on DT.DuplicationTypeId = DSP.DuplicationTypeId
	WHERE	DSP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
			AND DSP.CompanyId = @CompanyId
			AND DSP.Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
