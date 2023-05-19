SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 13-NOV-2022
-- Description:	To populate QDM tables for the measure CMS138v10_NQF0028
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS138v10_NQF0028_Medication]  
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
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1, @StartDate);
	
	-- Medication, Active
	INSERT INTO [cqm2022].[PatientMedicationCodes]	
	(PatientId, EncounterId, DoctorId, MedicationId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pam.pa_id, [cqm2022].[FindClosestEncounter](pam.date_added, pam.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pam.pam_id, cqm.Code, cqm.CodeSystemId, pam.date_added 
	FROM patient_active_meds pam WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON  pam.pa_id=pat.pa_id
	INNER JOIN dbo.vwRxNormCodes vwRx WITH(NOLOCK) ON vwRx.MedId = CAST(pam.drug_id AS VARCHAR)
	INNER JOIN [cqm2022].[SysLookupCMS138v10_NQF0028] cqm WITH(NOLOCK) on cqm.code = vwRx.RxNormCode
	LEFT JOIN [cqm2022].[PatientMedicationCodes] pmc WITH(NOLOCK) on pmc.EncounterId = EncounterId AND pmc.MedicationId = pam.pam_id AND pmc.Code = cqm.Code AND pmc.PatientId = pam.pa_id
	where pam.date_added between @measureStartDate and @EndDate
	AND added_by_dr_id = @DoctorId
	AND cqm.QDMCategoryId = 5 AND cqm.CodeSystemId = 26 AND cqm.ValueSetId = 166 
	AND pmc.MedicationCodeId IS NULL
	
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
