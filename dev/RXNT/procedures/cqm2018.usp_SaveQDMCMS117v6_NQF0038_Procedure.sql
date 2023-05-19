SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 8th-Feb-2018
-- Description:	To populate QDM tables for the measure CMS117v6_NQF0038
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SaveQDMCMS117v6_NQF0038_Procedure]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId

	-- Procedure Performed
	INSERT INTO cqm2018.PatientProcedureCodes
	(PatientId, EncounterId, DoctorId, ProcedureId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pp.pa_id, [cqm2018].[FindClosestEncounter](pp.date_performed, pp.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pp.procedure_id, cqm.Code, cqm.CodeSystemId, pp.date_performed
	FROM patient_procedures pp WITH(NOLOCK)
	INNER JOIN [cqm2018].[SysLookupCMS117v6_NQF0038] cqm WITH(NOLOCK) on cqm.code = pp.code
	LEFT JOIN [cqm2018].[PatientProcedureCodes] ppc WITH(NOLOCK) on ppc.EncounterId = EncounterId AND ppc.ProcedureId = pp.procedure_id
	WHERE cqm.QDMCategoryId = 10 AND cqm.ValueSetId IN (115,118,121,124,126,128,135,140,143,145,154)
	AND pp.dr_id = @DoctorId
	AND pp.date_performed BETWEEN @StartDate AND @EndDate
	AND ppc.ProcedureCodeId IS NULL
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO