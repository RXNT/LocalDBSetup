SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 9-NOV-2022
-- Description:	To populate QDM tables for the measure CMS136v12_NQF0108
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SaveQDMCMS136v12_NQF0108_Medication]
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
	FROM cqm2023.[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,@StartDate)
	
	-- Medication, Active
	INSERT INTO cqm2023.PatientMedicationCodes	
	(PatientId, EncounterId, DoctorId, MedicationId, Code, CodeSystemId, PerformedFromDate,PerformedToDate)
	SELECT TOP(@MaxRowsCount) pam.pa_id, cqm2023.[FindClosestEncounter](pam.date_added, pam.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pam.pam_id, cqm.Code, cqm.CodeSystemId, pam.date_added ,pam.date_end
	FROM patient_active_meds pam  WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pam.pa_id=pat.pa_id
	INNER JOIN (
			SELECT  r1.evd_fdb_vocab_id ddid,EVD_EXT_VOCAB_ID RxNORMCode from revdel0 r1 WITH(NOLOCK) 
	INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id
	INNER JOIN cqm2023.[SysLookupCMS136v12_NQF0108] cqm WITH(NOLOCK)  ON cqm.Code = EVD_EXT_VOCAB_ID
	) Rxn ON rxn.ddid = CAST(pam.drug_id AS VARCHAR(20))
	INNER JOIN cqm2023.[SysLookupCMS136v12_NQF0108] cqm  WITH(NOLOCK) on cqm.code = rxn.RxNORMCode
	LEFT JOIN cqm2023.PatientMedicationCodes pmc  WITH(NOLOCK) on pmc.EncounterId = EncounterId AND pmc.MedicationId = pam.pam_id AND pmc.Code = cqm.Code AND pmc.PatientId = pam.pa_id
	where pam.date_added between @measureStartDate and @EndDate
	AND added_by_dr_id = @DoctorId
	AND cqm.QDMCategoryId = 5 AND cqm.ValueSetId = 22 
	AND pmc.MedicationId IS NULL
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
	SET @AffectedRows = @tempRowCount;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
