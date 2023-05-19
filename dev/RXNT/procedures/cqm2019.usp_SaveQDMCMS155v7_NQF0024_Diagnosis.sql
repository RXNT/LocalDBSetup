SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 15-NOV-2018
-- Description:	To populate QDM tables for the measure CMS155v7_NQF0024
-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SaveQDMCMS155v7_NQF0024_Diagnosis]
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
	
		--Diagnosis ICD9
	INSERT INTO cqm2019.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT pad.pad, 
	[cqm2019].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id= pad.pa_id
	INNER JOIN cqm2019.SysLookUpCMS155v7_NQF0024 cqm WITH(NOLOCK) ON pad.icd9 = cqm.code 
	LEFT JOIN cqm2019.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId 
	WHERE pad.added_by_dr_id = @DoctorId 
	AND pad.date_added between @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (6,8) AND cqm.ValueSetId = 97
	AND pdc.DiagnosisCodeId Is NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	--Diagnosis ICD10
	INSERT INTO cqm2019.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT pad.pad, 
	[cqm2019].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id= pad.pa_id
	INNER JOIN cqm2019.SysLookUpCMS155v7_NQF0024 cqm WITH(NOLOCK) ON pad.icd10 = cqm.code 
	LEFT JOIN cqm2019.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId 
	WHERE pad.added_by_dr_id = @DoctorId 
	AND pad.date_added between @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (6,8) AND cqm.ValueSetId = 97
	AND pdc.DiagnosisCodeId Is NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	--Diagnosis snomed
	INSERT INTO cqm2019.PatientDiagnosisCodes
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate)
	SELECT pad.pad, 
	[cqm2019].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id= pad.pa_id
	INNER JOIN cqm2019.SysLookUpCMS155v7_NQF0024 cqm WITH(NOLOCK) ON pad.snomed_code = cqm.code 
	LEFT JOIN cqm2019.PatientDiagnosisCodes pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId 
	WHERE pad.added_by_dr_id = @DoctorId 
	AND pad.date_added between @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (6,8) AND cqm.ValueSetId = 97
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
