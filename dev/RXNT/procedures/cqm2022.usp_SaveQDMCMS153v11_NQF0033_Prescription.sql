SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 14-NOV-2022
-- Description:	To populate QDM tables for the measure CMS153v11_NQF0033
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SaveQDMCMS153v11_NQF0033_Prescription]
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
	FROM [cqm2022].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	-- Medication, Order
	INSERT INTO cqm2022.PatientMedicationCodes
	(PatientId, EncounterId, DoctorId, PrescriptionId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount) pres_num.pa_id, [cqm2022].[FindClosestEncounter](pres_num.pres_approved_date, pres_num.pa_id, @DoctorId) AS EncounterId,
	@DoctorId, pres_num.pres_id, cqm.Code, cqm.CodeSystemId, pres_num.pres_approved_date 
	FROM Prescriptions pres_num WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pres_num.pa_id=pat.pa_id
	INNER JOIN prescription_details pd_num WITH(NOLOCK) ON pres_num.pres_id=pd_num.pres_id 
	INNER JOIN dbo.vwRxNormCodes vwRx WITH(NOLOCK) ON vwRx.MedId = CAST(pd_num.ddid AS VARCHAR)
	INNER JOIN cqm2022.[SysLookupCMS153v11_NQF0033] cqm WITH(NOLOCK) on cqm.code = vwRx.RxNormCode
	LEFT JOIN cqm2022.PatientMedicationCodes pmc WITH(NOLOCK) on pmc.EncounterId = EncounterId AND pmc.PrescriptionId = pres_num.pres_id AND pmc.Code = cqm.Code AND pmc.PatientId =  pres_num.pa_id
	where pres_num.pres_approved_date between @StartDate AND @EndDate AND pres_num.pres_void = 0 AND pd_num.history_enabled = 1  	
	AND pres_num.dr_id = @DoctorId
	AND cqm.QDMCategoryId = 5 AND cqm.CodeSystemId = 26 AND cqm.ValueSetId IN (73,81)
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
