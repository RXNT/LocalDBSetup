SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-February-2018
-- Description:	To populate QDM tables for the measure CMS68V7_NQF0419_Procedure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SaveQDMCMS68V7_NQF0419_Procedure]
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
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	
	
	--Medication Substitued For Procedures
	INSERT INTO cqm2018.PatientMedicationCodes	
	(PatientId, EncounterId, DoctorId, MedicationId, Code, CodeSystemId, PerformedFromDate)
    SELECT TOP(@MaxRowsCount) pam.pa_id, [cqm2018].[FindClosestEncounter](pam.date_added, pam.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pam.pam_id, cqm.Code, cqm.CodeSystemId, pam.date_added 
	FROM patient_active_meds pam WITH(NOLOCK)
	LEFT JOIN cqm2018.[SysLookupCMS68v7_NQF0419] cqm WITH(NOLOCK) on cqm.code = '428191000124101'
	LEFT JOIN cqm2018.PatientMedicationCodes pmc WITH(NOLOCK) on pmc.EncounterId = EncounterId AND pmc.MedicationId = pam.pam_id AND pmc.Code = cqm.Code AND pmc.PatientId = pam.pa_id
	where pam.date_added between @StartDate and @EndDate
	AND added_by_dr_id = @DoctorId
	AND cqm.QDMCategoryId = 10 AND cqm.ValueSetId=6  AND cqm.CodeSystemId = 5
	AND pmc.MedicationCodeId IS NULL
	
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
