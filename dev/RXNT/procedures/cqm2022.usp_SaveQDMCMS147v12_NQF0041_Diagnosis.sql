SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 11-MAY-2023
-- Description:	To populate QDM tables for the measure CMS147v12_NQF0041
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS147v12_NQF0041_Diagnosis]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @DefaultEncCode VARCHAR(MAX) = '99201';
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2022].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	-- Diagnosis ICD 9
	INSERT INTO cqm2022.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT DISTINCT TOP(@MaxRowsCount) pad.pad, 
	[cqm2022].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON  pad.pa_id=pat.pa_id
	INNER JOIN cqm2022.SysLookupCMS147v12_NQF0041 cqm WITH(NOLOCK) ON pad.icd9 = cqm.code 
	LEFT JOIN cqm2022.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId
	WHERE pad.added_by_dr_id = @DoctorId
	AND pad.date_added between @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId IN (48 ,49,59)
	AND pdc.DiagnosisCodeId Is NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows = @tempRowCount;
	 END
	 
	 -- Diagnosis ICD 10
	INSERT INTO cqm2022.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT DISTINCT TOP(@MaxRowsCount) pad.pad, 
	[cqm2022].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON  pad.pa_id=pat.pa_id
	INNER JOIN cqm2022.SysLookupCMS147v12_NQF0041 cqm WITH(NOLOCK) ON pad.icd10 = cqm.code
	LEFT JOIN cqm2022.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId AND pdc.Code = cqm.Code
	WHERE pad.added_by_dr_id = @DoctorId
	AND pad.date_added between @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId IN (48 ,49,59)
	AND pdc.DiagnosisCodeId Is NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows = @tempRowCount;
	 END
	 
	 -- Diagnosis SNOMED
	INSERT INTO cqm2022.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT DISTINCT TOP(@MaxRowsCount) pad.pad, 
	[cqm2022].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id, cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON  pad.pa_id=pat.pa_id
	INNER JOIN cqm2022.SysLookupCMS147v12_NQF0041 cqm WITH(NOLOCK) ON pad.snomed_code = cqm.code
	LEFT JOIN cqm2022.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId AND pdc.Code = cqm.Code
	WHERE pad.added_by_dr_id = @DoctorId
	AND pad.date_added between @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 1  AND cqm.ValueSetId IN (48 ,49,59)
	AND pdc.DiagnosisCodeId Is NULL
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
