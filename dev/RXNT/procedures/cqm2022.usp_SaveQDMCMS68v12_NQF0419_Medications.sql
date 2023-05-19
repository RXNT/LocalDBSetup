SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 2nd-November-2022
-- Description:	To populate QDM tables for the measure CMS68v12_NQF0419_Procedure
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS68v12_NQF0419_Medications]
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
	
	
	
	--Medication Substitued For Procedures
	INSERT INTO cqm2022.PatientMedicationCodes	
	(PatientId, EncounterId, DoctorId, MedicationId, Code, CodeSystemId, PerformedFromDate)
    SELECT TOP(@MaxRowsCount) pam.pa_id, [cqm2022].[FindClosestEncounter](pam.date_added, pam.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pam.pam_id, cqm.Code, cqm.CodeSystemId, pam.date_added 
	FROM patient_active_meds pam WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pam.pa_id=pat.pa_id
	LEFT JOIN cqm2022.[SysLookupCMS68v12_NQF0419] cqm WITH(NOLOCK) ON cqm.code = '428191000124101'
	LEFT JOIN cqm2022.PatientMedicationCodes pmc WITH(NOLOCK) on pmc.EncounterId = EncounterId AND pmc.MedicationId = pam.pam_id AND pmc.Code = cqm.Code AND pmc.PatientId = pam.pa_id
	where pam.date_added between @StartDate and @EndDate
	AND added_by_dr_id = @DoctorId
	AND cqm.QDMCategoryId = 10 AND cqm.ValueSetId=174  AND cqm.CodeSystemId IN (2,27,28,29,30,31)
	AND pmc.MedicationCodeId IS NULL
	

	SELECT TOP(@MaxRowsCount) enc.patient_id, enc.enc_id, enc.dr_id, @DefaultEncCode, '4', enc.enc_date 
	FROM enchanced_encounter enc WITH(NOLOCK)
	INNER JOIN doctors dr  WITH(NOLOCK) ON enc.dr_id=dr.dr_id
	INNER JOIN patients pat WITH(NOLOCK) ON enc.patient_id=pat.pa_id AND dr.dg_id=pat.dg_id
	INNER JOIN cqm2022.SysLookupCMS68v12_NQF0419 cqm  WITH(NOLOCK) ON cqm.Code = @DefaultEncCode
	LEFT OUTER JOIN  patient_procedures proce WITH(NOLOCK) ON  enc.patient_id = proce.pa_id AND proce.type='Procedure' AND CAST(proce.date_performed AS DATE)= CAST(enc.enc_date AS DATE)
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
