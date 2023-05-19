SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed	
-- Create date: 31st-October-2022
-- Description:	To populate QDM tables for the measure CMS68v11_NQF0419_Encounters
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS68v11_NQF0419_Encounter]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @DefaultEncCode VARCHAR(MAX) = '99202';
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2022].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	-- Encounters 
	INSERT INTO cqm2022.PatientEncounterCodes 
	(PatientId, EncounterId, DoctorId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) proce.pa_id, 0, proce.dr_id, proce.code, '3', proce.date_performed 
	FROM patient_procedures proce WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON proce.pa_id=pat.pa_id
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dg_id=pat.dg_id AND proce.dr_id=dr.dr_id
	INNER JOIN cqm2022.SysLookupCMS68v11_NQF0419 cqm  WITH(NOLOCK) ON cqm.Code = proce.code AND proce.type='Encounter'
	LEFT JOIN cqm2022.PatientEncounterCodes pec WITH(NOLOCK) ON  pec.Code = proce.code AND pec.PerformedFromDate = proce.date_performed
	WHERE proce.dr_id = @DoctorId AND-- issigned = 1 AND
	proce.date_performed between @StartDate AND @EndDate and cqm.ValueSetId = 1 
	AND pec.EncounterCodeId IS NULL
	UNION
	SELECT TOP(@MaxRowsCount) enc.patient_id, enc.enc_id, enc.dr_id, @DefaultEncCode, '4', enc.enc_date 
	FROM enchanced_encounter enc WITH(NOLOCK)
	INNER JOIN doctors dr  WITH(NOLOCK) ON enc.dr_id=dr.dr_id
	INNER JOIN patients pat WITH(NOLOCK) ON enc.patient_id=pat.pa_id AND dr.dg_id=pat.dg_id
	INNER JOIN cqm2022.SysLookupCMS68v11_NQF0419 cqm  WITH(NOLOCK) ON cqm.Code = @DefaultEncCode
	LEFT OUTER JOIN  patient_procedures proce WITH(NOLOCK) ON  enc.patient_id = proce.pa_id AND proce.type='Encounter' AND CAST(proce.date_performed AS DATE)= CAST(enc.enc_date AS DATE)
	LEFT JOIN cqm2022.PatientEncounterCodes pec WITH(NOLOCK) ON pec.EncounterId = enc.enc_id AND pec.Code = @DefaultEncCode AND pec.PerformedFromDate = enc.enc_date
	WHERE enc.dr_id = @DoctorId AND issigned = 1 AND
	enc.enc_date between @StartDate AND @EndDate and cqm.ValueSetId = 1 
	AND pec.EncounterCodeId IS NULL
	AND proce.procedure_id IS NULL

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
