SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 14-NOV-2022
-- Description:	To populate QDM tables for the measure CMS153v10_NQF0033
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS153v10_NQF0033_Medication]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE

	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2022].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	--Medication
	INSERT INTO cqm2022.PatientMedicationCodes	
	(PatientId, EncounterId, DoctorId, MedicationId, Code, CodeSystemId, PerformedFromDate)
    SELECT TOP(@MaxRowsCount) pam.pa_id, [cqm2022].[FindClosestEncounter](pam.date_added, pam.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pam.pam_id, cqm.Code, cqm.CodeSystemId, pam.date_added 
	FROM patient_active_meds pam WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pam.pa_id=pat.pa_id
	INNER JOIN dbo.vwRxNormCodes vwRx WITH(NOLOCK) ON vwRx.MedId = CAST(pam.drug_id AS VARCHAR)
	INNER JOIN cqm2022.[SysLookupCMS153v10_NQF0033] cqm WITH(NOLOCK) on cqm.code = vwRx.RxNormCode
	LEFT JOIN cqm2022.PatientMedicationCodes pmc WITH(NOLOCK) on pmc.EncounterId = EncounterId AND pmc.MedicationId = pam.pam_id AND pmc.Code = cqm.Code AND pmc.PatientId = pam.pa_id
	WHERE added_by_dr_id = @DoctorId 
	AND (
		pam.date_added between @StartDate and @EndDate 
		OR
		pam.date_end between @StartDate and @EndDate 
	)
	AND cqm.QDMCategoryId = 5 AND cqm.ValueSetId=73  AND cqm.CodeSystemId = 26
	AND pmc.MedicationCodeId IS NULL	

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
