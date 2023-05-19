SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author: Niyaz
-- Create date: 15-NOV-2018
-- Description: To save the numerator for the measure
-- =============================================

CREATE PROCEDURE [cqm2019].[usp_SavePop1NumeratorCMS155v7_NQF0024]  
@RequestId BIGINT  
AS
BEGIN
DECLARE @DoctorId BIGINT
DECLARE @DoctorCompanyId BIGINT
DECLARE @StartDate DATE
DECLARE @EndDate DATE
DECLARE @MaxRowCount INT = 10
DECLARE @AffectedRows BIGINT = 0;
DECLARE @tempRowCount INT = 0;


SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
FROM [cqm2019].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK)
INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
WHERE RequestId = @RequestId
IF OBJECT_ID('tempdb..#usp_SavePop1NumeratorCMS155v7_NQF0024') IS NOT NULL DROP TABLE #usp_SavePop1NumeratorCMS155v7_NQF0024
SELECT TOP(@MaxRowCount) IPP.CalcId
INTO #usp_SavePop1NumeratorCMS155v7_NQF0024
FROM cqm2019.[DoctorCQMCalcPop1CMS155v7_NQF0024] IPP WITH(NOLOCK)
INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
INNER JOIN cqm2019.PatientPhysicalExamCodes bmi WITH(NOLOCK) ON bmi.PatientId = IPP.PatientId
INNER JOIN [cqm2019].[SysLookUpCMS155v7_NQF0024] cqm1 WITH(NOLOCK) ON cqm1.Code = bmi.Code
INNER JOIN cqm2019.PatientPhysicalExamCodes height WITH(NOLOCK) ON height.PatientId = IPP.PatientId
INNER JOIN [cqm2019].[SysLookUpCMS155v7_NQF0024] cqm2 WITH(NOLOCK) ON cqm2.Code = height.Code
INNER JOIN cqm2019.PatientPhysicalExamCodes weight WITH(NOLOCK) ON weight.PatientId = IPP.PatientId
INNER JOIN [cqm2019].[SysLookUpCMS155v7_NQF0024] cqm3 WITH(NOLOCK) ON cqm3.Code = weight.Code
WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
AND ISNULL(IPP.Numerator,0)=0
AND cqm1.QDMCategoryId = 12 AND cqm1.CodeSystemId = 13 AND cqm1.ValueSetId = 93
AND bmi.PerformedFromDate BETWEEN @StartDate AND @EndDate
AND cqm2.QDMCategoryId = 12 AND cqm2.CodeSystemId = 13 AND cqm2.ValueSetId = 96
AND height.PerformedFromDate BETWEEN @StartDate AND @EndDate
AND cqm3.QDMCategoryId = 12 AND cqm3.CodeSystemId = 13 AND cqm3.ValueSetId = 98
AND weight.PerformedFromDate BETWEEN @StartDate AND @EndDate

UPDATE TOP(@MaxRowCount) IPP
SET Numerator = 1
FROM cqm2019.[DoctorCQMCalcPop1CMS155v7_NQF0024] IPP WITH(NOLOCK)
INNER JOIN #usp_SavePop1NumeratorCMS155v7_NQF0024 IPP_Temp WITH(NOLOCK) ON IPP.CalcId=IPP_Temp.CalcId

SET @tempRowCount = @@ROWCOUNT;
IF @tempRowCount > @AffectedRows
BEGIN
SET @AffectedRows = @tempRowCount;
END

SELECT @AffectedRows;
DROP TABLE #usp_SavePop1NumeratorCMS155v7_NQF0024

END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
