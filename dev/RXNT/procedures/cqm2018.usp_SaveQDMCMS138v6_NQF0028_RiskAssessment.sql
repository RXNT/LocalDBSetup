SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To populate QDM tables for the measure CMS138v6_NQF0028
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SaveQDMCMS138v6_NQF0028_RiskAssessment]
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
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1, @StartDate);
	
	-- Risk Category Assessment Tobacco User
	INSERT INTO [cqm2018].[PatientRiskCategoryOrAssessmentCodes]
	(PatientId, EncounterId, DoctorId, RiskCategoryOrAssessmentId, Code, CodeSystemId, PerformedFromDate,PerformedToDate)
	SELECT DISTINCT pec.PatientId, pec.EncounterId, pec.DoctorId, pfd.pa_flag_id,'39240-7', 11, pec.PerformedFromDate, pec.PerformedToDate
	FROM [cqm2018].[PatientEncounterCodes] pec WITH(NOLOCK)
	INNER JOIN patient_flag_details pfd  WITH(NOLOCK) ON pfd.pa_id = pec.PatientId 
	LEFT JOIN cqm2018.PatientRiskCategoryOrAssessmentCodes prc WITH(NOLOCK) ON prc.PatientID = pec.PatientId AND prc.RiskCategoryOrAssessmentId = pfd.pa_flag_id AND prc.DoctorId = pec.DoctorId
	WHERE pfd.flag_id IN (-5,-4,-3,-2,-1,5,6,7,136,178,218,235,346,347,410,411,471,472,485,519,520,535,621,829,879,880,993) AND pec.PerformedFromDate BETWEEN @measureStartDate AND @EndDate AND (pfd.date_added IS NULL OR pfd.date_added > @measureStartDate)
	AND pec.DoctorId = @DoctorId AND prc.RiskCategoryOrAssessmentCodeId IS NULL
	
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
