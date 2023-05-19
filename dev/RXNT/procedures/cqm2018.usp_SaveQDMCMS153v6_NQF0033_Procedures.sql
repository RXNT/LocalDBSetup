SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To populate QDM tables for the measure CMS153v6_NQF0033
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SaveQDMCMS153v6_NQF0033_Procedures]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @DefaultEncCode VARCHAR(MAX) = '99201';

	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId

	-- Procedures
	INSERT INTO cqm2018.PatientProcedureCodes
	(PatientId, EncounterId, DoctorId, ProcedureId, Code, CodeSystemId, PerformedFromDate)
	SELECT pp.pa_id, [cqm2018].[FindClosestEncounter](pp.date_performed, pp.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pp.procedure_id, cqm.Code, cqm.CodeSystemId, pp.date_performed
	FROM patient_procedures pp WITH(NOLOCK)
	INNER JOIN cqm2018.[SysLookupCMS153v6_NQF0033] cqm WITH(NOLOCK) on cqm.code = pp.code
	LEFT JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) on ppc.EncounterId = EncounterId AND ppc.ProcedureId = pp.procedure_id
	WHERE cqm.QDMCategoryId = 10 AND cqm.ValueSetId IN (74,87,88)
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
