SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 8th-NOV-2022
-- Description:	To populate QDM tables for the measure CMS117v11_NQF0038
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SaveQDMCMS117v11_NQF0038_Intervention]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2023].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId

	-- Procedure Performed
	INSERT INTO cqm2023.PatientInterventionCodes
	(PatientId, EncounterId, DoctorId, InterventionId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pp.pa_id, [cqm2023].[FindClosestEncounter](pp.date_performed, pp.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pp.procedure_id, cqm.Code, cqm.CodeSystemId, pp.date_performed
	FROM patient_procedures pp WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=pp.pa_id
	INNER JOIN [cqm2023].[SysLookupCMS117v11_NQF0038] cqm  WITH(NOLOCK) on cqm.code = pp.code
	LEFT JOIN cqm2023.PatientInterventionCodes ppc WITH(NOLOCK) on ppc.EncounterId = EncounterId AND ppc.InterventionId = pp.procedure_id
	WHERE cqm.QDMCategoryId = 4 AND cqm.ValueSetId IN (31)
	AND pp.dr_id = @DoctorId
	AND pp.date_performed BETWEEN @StartDate AND @EndDate
	AND ppc.InterventionCodeId IS NULL
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
	SET @AffectedRows = @tempRowCount;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO