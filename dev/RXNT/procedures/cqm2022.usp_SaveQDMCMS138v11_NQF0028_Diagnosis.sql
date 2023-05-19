SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 11-MAY-2023
-- Description:	To populate QDM tables for the measureCMS138v11_NQF0028
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS138v11_NQF0028_Diagnosis]
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
	
	--Diagnosis SNOMEDCT
	INSERT INTO [cqm2022].[PatientDiagnosisCodes]
	(DiagnosisId, EncounterId, PatientId, DoctorId, CodeSystemId, Code, PerformedFromDate,PerformedToDate)
	SELECT pad.pad, 
	[cqm2022].[FindClosestEncounter](pad.date_added, pad.pa_id, @DoctorId) AS EncounterId,
	pad.pa_id, pad.added_by_dr_id,cqm.CodeSystemId, cqm.Code, pad.date_added,pad.status_date
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pad.pa_id=pat.pa_id
	INNER JOIN [cqm2022].[SysLookUpCMS138v11_NQF0028] cqm WITH(NOLOCK) ON pad.snomed_code = cqm.code 
	LEFT JOIN [cqm2022].[PatientDiagnosisCodes] pdc WITH(NOLOCK) on pad.pad = pdc.DiagnosisId AND pdc.EncounterId = EncounterId 
	WHERE pad.added_by_dr_id = @DoctorId 
	AND pad.date_added between @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (2,27,28,29,30,31) AND cqm.ValueSetId = 158
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
