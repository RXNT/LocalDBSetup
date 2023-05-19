SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 13-NOV-2022
-- Description:	To save the initial patient population for the measure
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SavePop1IPPCMS138v10_NQF0028]
	@RequestId BIGINT  
AS
BEGIN

	DECLARE @MaxRecords BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM cqm2022.DoctorCQMCalculationRequest DCCR WITH(NOLOCK)
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,'2022-01-01 00:00:00');

	INSERT INTO cqm2022.DoctorCQMCalcPop1CMS138v10_NQF0028
    (PatientId, IPP, Denominator, DoctorId, RequestId)   
    SELECT DISTINCT TOP(@MaxRecords) pat.pa_id, 1, 1, @DoctorId, @RequestId 
    FROM patients pat WITH(NOLOCK) 
    INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.PatientEncounterCodes pec ON pec.PatientId=pat.pa_id
	LEFT JOIN [cqm2022].[DoctorCQMCalcPop1CMS138v10_NQF0028] IPP ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.CalcId IS NULL AND datediff(month,PAT.pa_dob,CONVERT(datetime,@StartDate)) >= 18*12 AND NOT (pa_dob LIKE '1901-01-01')
	
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
