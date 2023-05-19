SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 8th-NOV-2018
-- Description:	To populate QDM tables for the measure CMS117v7_NQF0038
-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SaveQDMCMS117v7_NQF0038_LabTest]
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
	FROM [cqm2019].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	INSERT INTO cqm2019.PatientLaboratoryTestCodes	
	(LaboratoryTestId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT TOP(@MaxRowsCount)  lrf.lab_result_info_id, 
	[cqm2019].[FindClosestEncounter](lrf.obs_date, lm.pat_id, @DoctorId) AS EncounterId,
	lm.pat_id,lm.dr_id,cqm.CodeSystemId, cqm.Code, lrf.obs_date
	FROM lab_result_info lrf WITH(NOLOCK)
	INNER JOIN lab_main lm WITH(NOLOCK) ON lm.lab_id = lrf.lab_id
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=lm.pat_id
	INNER JOIN [cqm2019].[SysLookupCMS117v7_NQF0038] cqm WITH(NOLOCK) ON lrf.obs_bat_ident = cqm.code 
	LEFT JOIN [cqm2019].[PatientLaboratoryTestCodes] pltc WITH(NOLOCK) on lrf.lab_result_info_id = pltc.LaboratoryTestId AND pltc.EncounterId = EncounterId 
	WHERE lm.dr_id = @DoctorId
	AND lrf.obs_date between @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 13
	AND cqm.ValueSetId IN (111,112,132,133,137,138,147,148,151,152)
	AND pltc.LaboratoryTestId Is NULL	
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
