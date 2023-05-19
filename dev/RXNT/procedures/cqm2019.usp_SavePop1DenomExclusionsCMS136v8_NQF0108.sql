SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 9-NOV-2018
-- Description:	To save the denominator Exclusions for the measure
-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SavePop1DenomExclusionsCMS136v8_NQF0108]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2019].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK)
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId;
	
	WITH InitialADHDMedication(pa_id,PerformedFromDate,PerformedToDate)
	AS
	(
		SELECT DISTINCT pmc.PatientId, pmc.PerformedFromDate,pmc.PerformedToDate
		FROM cqm2019.PatientMedicationCodes pmc WITH(NOLOCK) 
		INNER JOIN cqm2019.SysLookupCMS136v8_NQF0108 cqm WITH(NOLOCK)  ON cqm.code = pmc.Code		
		LEFT JOIN cqm2019.DoctorCQMCalcPop1CMS136v8_NQF0108 IPP  WITH(NOLOCK) on IPP.PatientId = pmc.PatientId AND IPP.RequestId = @RequestId
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	    INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
		WHERE dg.dc_id=@DoctorCompanyId AND pmc.DoctorId = @DoctorId	
		AND cqm.QDMCategoryId = 5  AND cqm.ValueSetId = 22
		AND DATEDIFF(DAY,@StartDate,pmc.PerformedFromDate) BETWEEN -90 AND 60	
		AND pmc.MedicationId IS NULL 	
	)
	
	
	UPDATE TOP(@MaxRowCount) IPP
	SET DenomExclusions = 1
	FROM cqm2019.[DoctorCQMCalcPop1CMS136v8_NQF0108] IPP
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN (
		SELECT DISTINCT PatientId 
		FROM cqm2019.PatientDiagnosisCodes pdc WITH(NOLOCK) 
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=pdc.PatientId
		INNER JOIN cqm2019.SysLookUpCMS136v8_NQF0108 cqm WITH(NOLOCK)  on cqm.code = pdc.code	
		WHERE pdc.DoctorId = @DoctorId AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 35
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		
		UNION 
		
		SELECT DISTINCT PatientId 
		FROM cqm2019.PatientInterventionCodes pic WITH(NOLOCK) 
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=pic.PatientId
		INNER JOIN cqm2019.SysLookUpCMS136v8_NQF0108 cqm WITH(NOLOCK)  on cqm.code = pic.code	
		WHERE pic.DoctorId = @DoctorId AND cqm.QDMCategoryId = 4 AND cqm.ValueSetId = 31
		AND (
			pic.PerformedFromDate BETWEEN @StartDate AND @EndDate
			OR
			pic.PerformedToDate BETWEEN @StartDate AND @EndDate
		)
		
		UNION
		
		SELECT DISTINCT pmc.PatientId
		FROM cqm2019.PatientMedicationCodes pmc  WITH(NOLOCK) 
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=pmc.PatientId
		INNER JOIN InitialADHDMedication M ON M.pa_id=pmc.PatientId
		INNER JOIN cqm2019.[SysLookUpCMS136v8_NQF0108] cqm WITH(NOLOCK)  on cqm.code = pmc.Code	
		WHERE pmc.DoctorId = @DoctorId 
		AND cqm.QDMCategoryId = 5 AND cqm.ValueSetId = 22 AND
		pmc.PerformedFromDate < pmc.PerformedFromDate AND DATEDIFF(DAY,pmc.PerformedFromDate,M.PerformedFromDate) <= 120
	) res  ON res.PatientId=IPP.PatientId		
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.DoctorId = @DoctorId
	AND IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0 AND IPP.RequestId = @RequestId
	
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
