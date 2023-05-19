SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 12-May-2017
-- Description:	To save the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop3IPPCMS138v6_NQF0028]
	@RequestId BIGINT  
AS
BEGIN

	DECLARE @MaxRecords BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM cqm2018.DoctorCQMCalculationRequest WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,'2017-01-01 00:00:00');

	INSERT INTO cqm2018.DoctorCQMCalcPop3CMS138v6_NQF0028
    (PatientId, IPP, Denominator, DoctorId, RequestId)   
    SELECT DISTINCT TOP(@MaxRecords) pat.pa_id, 1, 1, @DoctorId, @RequestId 
    FROM patients pat WITH(NOLOCK) 
	INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK) ON pec.PatientId=pat.pa_id
	LEFT JOIN [cqm2018].[DoctorCQMCalcPop3CMS138v6_NQF0028] IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE IPP.CalcId IS NULL AND datediff(month,PAT.pa_dob,CONVERT(datetime,@StartDate)) >= 18*12 AND NOT (pa_dob LIKE '1901-01-01')
	
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
