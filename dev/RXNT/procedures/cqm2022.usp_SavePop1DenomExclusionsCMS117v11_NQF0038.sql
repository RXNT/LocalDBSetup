SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 8-NOV-2022
-- Description:	To save the denominator Exclusions for the measure
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SavePop1DenomExclusionsCMS117v11_NQF0038]
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
	FROM cqm2022.[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	UPDATE TOP(@MaxRowCount) IPP
	SET DenomExclusions = 1
	FROM [cqm2022].[DoctorCQMCalcPop1CMS117v11_NQF0038] IPP
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.PatientInterventionCodes pic ON pic.PatientId = IPP.PatientId
	INNER JOIN [cqm2022].[SysLookupCMS117v11_NQF0038] cqm on cqm.code = pic.code
	INNER JOIN cqm2022.PatientEncounterCodes pec ON pec.EncounterId = pic.EncounterId
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
	AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0)
	AND pic.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 4 AND cqm.ValueSetId = 31 
	
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
