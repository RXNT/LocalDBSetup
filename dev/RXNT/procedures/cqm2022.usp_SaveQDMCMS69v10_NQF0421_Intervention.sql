SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 29th-OCT-2022
-- Description:	To populate QDM tables for the measure CMS69v10_0421
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS69v10_NQF0421_Intervention]
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
	FROM [cqm2022].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	--Interventions 
	INSERT INTO cqm2022.PatientInterventionCodes
	(PatientId, EncounterId, DoctorId, InterventionId, Code, CodeSystemId, PerformedFromDate)
	SELECT pp.pa_id, [cqm2022].[FindClosestEncounter](pp.date_performed, pp.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pp.procedure_id, cqm.Code, cqm.CodeSystemId, pp.date_performed
	FROM patient_procedures pp WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pp.pa_id=pat.pa_id
	INNER JOIN [cqm2022].[SysLookUpCMS69v10_NQF0421] cqm WITH(NOLOCK) on cqm.code = pp.code
	LEFT JOIN cqm2022.PatientInterventionCodes ppc WITH(NOLOCK) on ppc.EncounterId = EncounterId AND ppc.InterventionId = pp.procedure_id
	WHERE cqm.QDMCategoryId = 4 AND cqm.ValueSetId IN (8,10,16,20)
	AND pp.dr_id = @DoctorId
	AND pp.date_performed BETWEEN @StartDate AND @EndDate
	AND ppc.InterventionId IS NULL	
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	SELECT @AffectedRows;	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
