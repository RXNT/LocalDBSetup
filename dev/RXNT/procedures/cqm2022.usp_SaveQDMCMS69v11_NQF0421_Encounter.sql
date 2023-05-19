SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =======================================
-- Author:		Rasheed
-- Create date: 29th-OCT-2022
-- Description:	To populate QDM tables for the measure CMS69v11_0421
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS69v11_NQF0421_Encounter]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @DefaultEncCode VARCHAR(MAX) = '90791';
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;

	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2022].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	-- Encounters
	INSERT INTO cqm2022.PatientEncounterCodes 
	(PatientId, EncounterId, DoctorId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pa_id,EncounterId,DoctorId, Code, CodeSystem, record_date FROM (
	SELECT pv.pa_id, [cqm2022].[FindClosestEncounter](pv.record_date, pv.pa_id, @DoctorId) AS EncounterId,
	@DoctorId as 'DoctorId', pv.pa_vt_id, @DefaultEncCode as 'Code', 4 as 'CodeSystem', pv.record_date
	FROM patient_vitals pv WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pv.pa_id=pat.pa_id
	LEFT JOIN cqm2022.PatientEncounterCodes pec WITH(NOLOCK) ON pec.PatientId = pv.pa_id AND pec.EncounterId = EncounterId AND pec.Code = @DefaultEncCode
	WHERE pv.added_for = @DoctorId
	AND pv.record_date BETWEEN @StartDate AND @EndDate
	AND pec.EncounterCodeId IS NULL) as i
	where i.EncounterId IS NOT NULL
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
