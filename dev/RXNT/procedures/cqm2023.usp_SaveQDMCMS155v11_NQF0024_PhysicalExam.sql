SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 15-NOV-2022
-- Description:	To populate QDM tables for the measure CMS155v11_NQF0024
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SaveQDMCMS155v11_NQF0024_PhysicalExam]
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
	
	--BMI 
	INSERT INTO cqm2023.PatientPhysicalExamCodes
	(PatientId, EncounterId, DoctorId, PhysicalExamId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pv.pa_id, [cqm2023].[FindClosestEncounter](pv.record_date, pv.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pv.pa_vt_id, '59574-4', 9, pv.record_date
	FROM patient_vitals pv WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=pv.pa_id
	LEFT JOIN cqm2023.PatientPhysicalExamCodes phec WITH(NOLOCK) ON phec.PatientId = pv.pa_id AND phec.PhysicalExamId = pv.pa_vt_id AND phec.Code = '59574-4'
	WHERE pv.added_for = @DoctorId
	AND pv.record_date BETWEEN @StartDate AND @EndDate
	AND phec.PhysicalExamCodeId IS NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	-- Height 
	INSERT INTO cqm2023.PatientPhysicalExamCodes
	(PatientId, EncounterId, DoctorId, PhysicalExamId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pv.pa_id, [cqm2023].[FindClosestEncounter](pv.record_date, pv.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pv.pa_vt_id, '8302-2', 9, pv.record_date
	FROM patient_vitals pv WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=pv.pa_id
	LEFT JOIN cqm2023.PatientPhysicalExamCodes phec WITH(NOLOCK) ON phec.PatientId = pv.pa_id AND phec.PhysicalExamId = pv.pa_vt_id AND phec.Code = '8302-2'
	WHERE pv.added_for = @DoctorId
	AND pv.record_date BETWEEN @StartDate AND @EndDate
	AND phec.PhysicalExamCodeId IS NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	-- Weight 
	INSERT INTO cqm2023.PatientPhysicalExamCodes
	(PatientId, EncounterId, DoctorId, PhysicalExamId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pv.pa_id, [cqm2023].[FindClosestEncounter](pv.record_date, pv.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pv.pa_vt_id, '29463-7', 9, pv.record_date
	FROM patient_vitals pv WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=pv.pa_id
	LEFT JOIN cqm2023.PatientPhysicalExamCodes phec WITH(NOLOCK) ON phec.PatientId = pv.pa_id AND phec.PhysicalExamId = pv.pa_vt_id AND phec.Code = '29463-7'
	WHERE pv.added_for = @DoctorId
	AND pv.record_date BETWEEN @StartDate AND @EndDate
	AND phec.PhysicalExamCodeId IS NULL
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
