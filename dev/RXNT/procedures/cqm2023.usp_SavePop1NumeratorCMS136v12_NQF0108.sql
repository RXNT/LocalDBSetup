SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 9-NOV-2022
-- Description:	To save the numerator for the measure
-- 
-- =============================================

CREATE    PROCEDURE [cqm2023].[usp_SavePop1NumeratorCMS136v12_NQF0108]
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
	FROM [cqm2023].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK)
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId;
	
	WITH InitialADHDMedication(pa_id, PerformedFromDate)
	AS
	(
		SELECT DISTINCT pmc.PatientId, pmc.PerformedFromDate
		FROM cqm2023.PatientMedicationCodes pmc with(NOLOCK)
		INNER JOIN cqm2023.SysLookupCMS136v12_NQF0108 cqm WITH(NOLOCK)  ON cqm.code = pmc.Code		
		LEFT JOIN cqm2023.DoctorCQMCalcPop1CMS136v12_NQF0108 IPP WITH(NOLOCK)  on IPP.PatientId = pmc.PatientId AND IPP.RequestId = @RequestId
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	    INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
		WHERE dg.dc_id=@DoctorCompanyId AND pmc.DoctorId = @DoctorId	
		AND cqm.QDMCategoryId = 5  AND cqm.ValueSetId = 22
		AND DATEDIFF(DAY,@StartDate,pmc.PerformedFromDate) BETWEEN -90 AND 60	
		AND pmc.MedicationId IS NULL 	
		AND IPP.CalcId IS NULL
	)
	
	UPDATE TOP(@MaxRowCount) cqm2023.DoctorCQMCalcPOP1CMS136v12_NQF0108
	SET Numerator = 1
	FROM cqm2023.DoctorCQMCalcPOP1CMS136v12_NQF0108 IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2023.PatientEncounterCodes pec WITH(NOLOCK)  on pec.PatientId = IPP.PatientId
	INNER JOIN [cqm2023].[SysLookupCMS136v12_NQF0108] cqm WITH(NOLOCK)  ON pec.Code = cqm.code	 
	INNER JOIN InitialADHDMedication M ON M.pa_id=IPP.PatientId	
	WHERE dg.dc_id=@DoctorCompanyId AND pec.DoctorId = @DoctorId AND cqm.QDMCategoryId = 2
	AND DATEDIFF(Day,pec.PerformedFromDate, M.PerformedFromDate) <=30
	AND IPP.Numerator IS NULL OR IPP.Numerator = 0

	
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
