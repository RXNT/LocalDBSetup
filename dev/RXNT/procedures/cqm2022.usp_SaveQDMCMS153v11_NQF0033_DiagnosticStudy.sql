SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 11-MAY-2023
-- Description:	To populate QDM tables for the measure CMS153v11_NQF0033
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS153v11_NQF0033_DiagnosticStudy]
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
	FROM [cqm2022].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	--Diagnostic Study
	INSERT INTO cqm2022.PatientDiagnosticStudyCodes	
	(DiagnosticStudyId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)	
	SELECT lrf.lab_result_info_id, 
	[cqm2022].[FindClosestEncounter](CASE WHEN lrf.obs_date LIKE '1901-01-01' THEN lm.message_date ELSE lrf.obs_date END, lm.pat_id, @DoctorId) AS EncounterId,
	lm.pat_id,lm.dr_id,cqm.CodeSystemId, cqm.Code, CASE WHEN lrf.obs_date LIKE '1901-01-01' THEN lm.message_date ELSE lrf.obs_date END
	FROM lab_result_info lrf WITH(NOLOCK)
	INNER JOIN lab_main lm WITH(NOLOCK) ON lm.lab_id = lrf.lab_id
	INNER JOIN patients pat WITH(NOLOCK) ON lm.pat_id=pat.pa_id
	INNER JOIN cqm2022.SysLookupCMS153v11_NQF0033 cqm WITH(NOLOCK) ON lrf.obs_bat_ident = cqm.code 
	LEFT JOIN cqm2022.PatientDiagnosticStudyCodes pltc WITH(NOLOCK) on lrf.lab_result_info_id = pltc.DiagnosticStudyId AND pltc.EncounterId = EncounterId 
	WHERE lm.dr_id = @DoctorId
	AND ((NOT (lrf.obs_date LIKE '1901-01-01') AND lrf.obs_date between @StartDate AND @EndDate) OR (lm.message_date between @StartDate AND @EndDate))
	AND cqm.QDMCategoryId = 15 AND cqm.CodeSystemId =25
	AND cqm.ValueSetId IN (75,91)
	AND pltc.DiagnosticStudyId Is NULL
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
