SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 6th-FEB-2022
-- Description:	To populate QDM tables for the measure CMS147v12_NQF0041
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SaveQDMCMS147v12_NQF0041_Encounter]
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
	FROM [cqm2023].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	-- Encounters
	INSERT INTO cqm2023.PatientEncounterCodes 
	(PatientId, EncounterId, DoctorId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) enc.patient_id, enc.enc_id, enc.dr_id, @DefaultEncCode, '4', enc.enc_date 
	FROM enchanced_encounter enc WITH(NOLOCK)
	LEFT JOIN cqm2023.PatientEncounterCodes pec WITH(NOLOCK) ON pec.EncounterId = enc.enc_id AND pec.Code = @DefaultEncCode
	WHERE dr_id = @DoctorId AND issigned = 1 AND
	enc.enc_date between @StartDate AND @EndDate
	AND pec.EncounterCodeId IS NULL
	
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
