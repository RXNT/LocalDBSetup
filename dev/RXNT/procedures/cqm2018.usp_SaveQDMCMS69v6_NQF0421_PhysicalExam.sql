SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 5th-FEB-2018
-- Description:	To populate QDM tables for the measure CMS69v6_0421
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SaveQDMCMS69v6_NQF0421_PhysicalExam]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId

	--Physical Exam, Performed 
	INSERT INTO cqm2018.PatientPhysicalExamCodes
	(PatientId, EncounterId, DoctorId, PhysicalExamId, Code, CodeSystemId, PerformedFromDate)
	SELECT pv.pa_id, [cqm2018].[FindClosestEncounter](pv.record_date, pv.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pv.pa_vt_id, '39156-5', 9, pv.record_date
	FROM patient_vitals pv WITH(NOLOCK)
	LEFT JOIN cqm2018.PatientPhysicalExamCodes phec WITH(NOLOCK) ON phec.PatientId = pv.pa_id AND phec.PhysicalExamId = pv.pa_vt_id AND phec.Code = '39156-5'
	WHERE pv.added_for = @DoctorId
	AND pv.record_date BETWEEN @StartDate AND @EndDate
	AND phec.PhysicalExamCodeId IS NULL
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
