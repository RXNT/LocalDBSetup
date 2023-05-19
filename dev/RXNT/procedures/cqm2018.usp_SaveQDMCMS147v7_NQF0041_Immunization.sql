SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6th-FEB-2018
-- Description:	To populate QDM tables for the measure CMS147v7_NQF0041
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SaveQDMCMS147v7_NQF0041_Immunization]
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
	
	
	-- Immunization, Administered
	INSERT INTO cqm2018.PatientImmunizationCodes
	(PatientId, EncounterId, DoctorId,VaccinationRecordId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount)  vr.vac_pat_id, [cqm2018].[FindClosestEncounter](vr.vac_dt_admin, vr.vac_pat_id, @DoctorId) AS EncounterId,
	@DoctorId, vr.vac_rec_id, cqm.Code, cqm.CodeSystemId, vr.vac_dt_admin 
	FROM tblVaccinationRecord vr WITH(NOLOCK)
	INNER JOIN tblVaccines vacc WITH(NOLOCK) ON vacc.vac_id = vr.vac_id
	INNER JOIN cqm2018.SysLookupCMS147v7_NQF0041 cqm WITH(NOLOCK) ON cqm.Code = vacc.CVX_CODE
	LEFT JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.EncounterId = EncounterId AND pmc.VaccinationRecordId = vr.vac_rec_id
	WHERE cqm.QDMCategoryId = 8 AND cqm.ValueSetId IN (58) AND cqm.CodeSystemId = 12
	AND vr.vac_dt_admin BETWEEN @StartDate AND @EndDate
	AND vr.vac_dr_id = @DoctorId AND pmc.ImmunizationCodeId IS NULL
	
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
