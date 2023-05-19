SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 11-MAY-2023
-- Description:	To populate QDM tables for the measure CMS153v11_NQF0033
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SaveQDMCMS153v11_NQF0033_Diagnosis]
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
	FROM [cqm2023].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	--Diagnosis ICD9
	INSERT INTO cqm2023.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pad.pad, 
	[cqm2023].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pad.pa_id=pat.pa_id
	INNER JOIN cqm2023.SysLookUpCMS153v11_NQF0033 cqm WITH(NOLOCK) ON pad.icd9 = cqm.code 
	LEFT JOIN cqm2023.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId 
	WHERE pad.added_by_dr_id = @DoctorId
	AND pad.date_added between @StartDate AND @EndDate
	AND (pad.date_added BETWEEN @StartDate AND @EndDate OR pad.status_date BETWEEN @StartDate AND @EndDate) 
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (2,21,23,27,28,29,30,31) -- Done 
	AND cqm.ValueSetId IN (70,72,77,78,79,80,84,90,188)
	AND pdc.DiagnosisCodeId Is NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	--Diagnosis ICD10
	INSERT INTO cqm2023.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pad.pad, 
	[cqm2023].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pad.pa_id=pat.pa_id
	INNER JOIN cqm2023.SysLookUpCMS153v11_NQF0033 cqm  WITH(NOLOCK)ON pad.icd10 = cqm.code 
	LEFT JOIN cqm2023.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId 
	WHERE pad.added_by_dr_id = @DoctorId
	AND (pad.date_added BETWEEN @StartDate AND @EndDate OR pad.status_date BETWEEN @StartDate AND @EndDate) 
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (2,21,23,27,28,29,30,31) -- Done 
	AND cqm.ValueSetId IN (70,72,77,78,79,80,84,90,188)
	AND pdc.DiagnosisCodeId Is NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	--Diagnosis SNOMED
	INSERT INTO cqm2023.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pad.pad, 
	[cqm2023].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pad.pa_id=pat.pa_id
	INNER JOIN cqm2023.SysLookUpCMS153v11_NQF0033 cqm WITH(NOLOCK) ON pad.snomed_code = cqm.code 
	LEFT JOIN cqm2023.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId 
	WHERE pad.added_by_dr_id = @DoctorId
	AND (pad.date_added BETWEEN @StartDate AND @EndDate OR pad.status_date BETWEEN @StartDate AND @EndDate) 
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (2,21,23,27,28,29,30,31) -- Done 
	AND cqm.ValueSetId IN (70,72,77,78,79,80,84,90,188)
	AND pdc.DiagnosisCodeId Is NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END	
	
	SELECT @AffectedRows
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO