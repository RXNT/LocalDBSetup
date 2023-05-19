SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 1st-NOV-2022
-- Description:	To populate QDM tables for the measure CMS138v10_NQF0028
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS138v10_NQF0028_Encounter] 
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT = 100
	DECLARE @DefaultEncCode VARCHAR(MAX) = '99201';
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2022].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	--DECLARE @measureStartDate DATETIME = DATEADD(year,-1, @StartDate);
	
	-- Encounters
	INSERT INTO [cqm2022].[PatientEncounterCodes]
	(PatientId, EncounterId, DoctorId, Code, CodeSystemId, PerformedFromDate,PerformedToDate)
	SELECT TOP(@MaxRowsCount) enc.patient_id, enc.enc_id, enc.dr_id, @DefaultEncCode, '4', enc.enc_date, enc.dtsigned
	FROM enchanced_encounter enc WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON enc.patient_id=pat.pa_id
	LEFT JOIN [cqm2022].[PatientEncounterCodes] pec WITH(NOLOCK) ON pec.EncounterId = enc.enc_id AND pec.Code = @DefaultEncCode
	WHERE enc.dr_id = @DoctorId AND issigned = 1 AND
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
