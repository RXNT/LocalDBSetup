SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 6th-FEB-2022
-- Description:	To populate QDM tables for the measure CMS136v12_NQF0108
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SaveQDMCMS136v12_NQF0108_Prescription]
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

	-- Medication Dispensed
	INSERT INTO cqm2023.PatientMedicationCodes
	(PrescriptionId, EncounterId, PatientId, DoctorId, Code, CodeSystemId, PerformedFromDate)
	SELECT pres_id,EncounterId,pa_id,dr_id,Code,CodeSystemId,pres_approved_date From 
	(SELECT DISTINCT TOP(@MaxRowsCount) pres_num.pres_id,
	[cqm2023].[FindClosestEncounter](pres_num.pres_approved_date, pres_num.pa_id, @DoctorId) AS EncounterId,
	pres_num.pa_id, pres_num.dr_id,  cqm.Code, cqm.CodeSystemId, pres_num.pres_approved_date
	FROM prescriptions pres_num WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pres_num.pa_id=pat.pa_id
	INNER JOIN prescription_details pd_num WITH(NOLOCK) ON pres_num.pres_id=pd_num.pres_id 
	INNER JOIN revdel0 r1 WITH(NOLOCK) ON r1.evd_fdb_vocab_id=CAST(pd_num.ddid AS VARCHAR)
	INNER JOIN [cqm2023].[SysLookupCMS136v12_NQF0108] cqm WITH(NOLOCK) ON cqm.Code = r1.EVD_EXT_VOCAB_ID
	LEFT JOIN cqm2023.PatientMedicationCodes pmc WITH(NOLOCK) on pmc.PrescriptionId = pres_num.pres_id AND pmc.EncounterId = EncounterId  AND pmc.PatientId = pres_num.pa_id
	where pres_num.dr_id = @DoctorId
	AND pres_num.pres_approved_date between @StartDate AND @EndDate AND pres_num.pres_void = 0 AND pd_num.history_enabled = 1  	
	AND cqm.QDMCategoryId = 5 AND cqm.ValueSetId = 22 
	AND pmc.PrescriptionId Is NULL) MD Where MD.EncounterId IS NOT NULL
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
