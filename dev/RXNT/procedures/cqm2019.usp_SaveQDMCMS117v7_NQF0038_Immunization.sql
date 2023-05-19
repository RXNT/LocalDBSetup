SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 8th-NOV-2018
-- Description:	To populate QDM tables for the measure CMS117v7_NQF0038
-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SaveQDMCMS117v7_NQF0038_Immunization]
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
	FROM [cqm2019].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	-- Immunization, Administered
	INSERT INTO [cqm2019].[PatientImmunizationCodes]
	(PatientId, EncounterId, DoctorId,VaccinationRecordId, Code, CodeSystemId, PerformedFromDate)
	SELECT TOP(@MaxRowsCount)  vr.vac_pat_id, [cqm2019].[FindClosestEncounter](vr.vac_dt_admin, vr.vac_pat_id, @DoctorId) AS EncounterId,
	@DoctorId, vr.vac_rec_id, cqm.Code, cqm.CodeSystemId, vr.vac_dt_admin 
	FROM tblVaccinationRecord vr WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=vr.vac_pat_id
	INNER JOIN tblVaccines vacc WITH(NOLOCK) ON vacc.vac_id = vr.vac_id
	INNER JOIN [cqm2019].[SysLookupCMS117v7_NQF0038] cqm WITH(NOLOCK) ON cqm.Code = vacc.CVX_CODE
	LEFT JOIN [cqm2019].[PatientImmunizationCodes] pmc WITH(NOLOCK) ON pmc.EncounterId = EncounterId AND pmc.VaccinationRecordId = vr.vac_rec_id
	WHERE cqm.ValueSetId IN (114,117,120,123,125,127,134,139,142,144,153,175) AND cqm.CodeSystemId=10 AND cqm.QDMCategoryId = 8
	AND vr.vac_dt_admin BETWEEN @StartDate AND @EndDate
	AND vr.vac_dr_id = @DoctorId AND pmc.ImmunizationCodeId IS NULL	
	
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
