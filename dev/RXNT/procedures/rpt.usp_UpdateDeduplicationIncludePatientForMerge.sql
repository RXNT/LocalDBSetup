SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to update Deduplication Warning Patient
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_UpdateDeduplicationIncludePatientForMerge]
(
	@CompanyId							BIGINT,
	@DoctorCompanyDeduplicateRequestId	BIGINT,
	@DeduplicationPatientIds			XML,
	@IncludePatientForMerge				BIT,
	@LoggedInUserId						BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;	
	DECLARE @CreatedDate AS DATETIME
	DECLARE @CreatedBy AS BIGINT
	
	SET @CreatedDate = GETDATE()

	IF ISNULL(@LoggedInUserId,0)<=0
	BEGIN
		SET @CreatedBy = 1
	END
	ELSE
	BEGIN
		SET @CreatedBy = @LoggedInUserId
	END
	
	UPDATE	DSP
	SET		DSP.IncludePatientForMerge = @IncludePatientForMerge,
			DSP.ModifiedBy = @CreatedBy,
			DSP.ModifiedDate = @CreatedDate
	FROM	rpt.DeduplicationPatients DSP
			INNER JOIN @DeduplicationPatientIds.nodes('ArrayOfLong/long') A(S) ON A.S.value('(text())[1]', 'BIGINT') = DSP.DeduplicationPatientId
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
