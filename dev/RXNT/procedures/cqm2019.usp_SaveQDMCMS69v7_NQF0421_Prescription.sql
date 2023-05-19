SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 29th-OCT-2018
-- Description:	To populate QDM tables for the measure CMS69v7_0421
-- =============================================

CREATE PROCEDURE [cqm2019].[usp_SaveQDMCMS69v7_NQF0421_Prescription]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2019].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	--Medication Order
	INSERT INTO cqm2019.PatientMedicationCodes
	(PrescriptionId, EncounterId, PatientId, DoctorId, Code, CodeSystemId, PerformedFromDate)
	SELECT DISTINCT pres_num.pres_id,
	[cqm2019].[FindClosestEncounter](pres_num.pres_approved_date, pres_num.pa_id, @DoctorId) AS EncounterId,
	pres_num.pa_id, pres_num.dr_id,  cqm.Code, cqm.CodeSystemId, pres_num.pres_approved_date
	FROM prescriptions pres_num WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pres_num.pa_id=pat.pa_id
	INNER JOIN prescription_details pd_num WITH(NOLOCK) ON pres_num.pres_id=pd_num.pres_id 
	INNER JOIN dbo.vwRxNormCodes vwRx WITH(NOLOCK) ON vwRx.MedId = CAST(pd_num.ddid AS VARCHAR)
	INNER JOIN [cqm2019].[SysLookUpCMS69v7_NQF0421] cqm WITH(NOLOCK) on cqm.code = vwRx.RxNormCode
	LEFT JOIN cqm2019.PatientMedicationCodes pmc WITH(NOLOCK) on pmc.PrescriptionId = pres_num.pres_id AND pmc.EncounterId = EncounterId  AND pmc.PatientId = pres_num.pa_id
	where pres_num.dr_id = @DoctorId
	AND pres_num.pres_approved_date between @StartDate AND @EndDate AND pres_num.pres_void = 0 AND pd_num.history_enabled = 1  	
	AND cqm.QDMCategoryId = 5 AND cqm.CodeSystemId = 7 AND cqm.ValueSetId IN (9,11)
	AND pmc.PrescriptionId Is NULL
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
