SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 
 
-- =============================================
-- Author:		Rasheed
-- Create date: 11-DEC-2022
-- Description:	To get the Doctor CQM request status 
-- =============================================
 
CREATE   PROCEDURE [cqm2022].[usp_GetDoctorQRDAIII_CMS147v11_NQF0041]  
	@DoctorId BIGINT,	
	@StartDate Date,
	@EndDate Date	
AS
BEGIN
 
	 DECLARE @RequestId BIGINT
	 SELECT @RequestId = MAX(RequestId) FROM  [cqm2022].[DoctorCQMCalculationRequest] R 
	 WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1
	 IF @RequestId>0
	 BEGIN
		 /*Complete*/
		 SELECT SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		 SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		 SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		 SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		 SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		 SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		 FROM  [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] N WITH(NOLOCK)
		 WHERE N.RequestId = @RequestId 
		 
		 --Race Wise
		 
		SELECT vwRace.RaceCode AS Code,SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		FROM patients pat WITH(NOLOCK) 
		INNER JOIN [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] N WITH(NOLOCK) ON pat.pa_id = N.PatientId
		INNER JOIN cqm.vwRaceCodes vwRace WITH(NOLOCK) ON pat.pa_race_type & vwRace.RaceId=vwRace.RaceId
		WHERE N.RequestId = @RequestId AND vwRace.RaceId>0
		GROUP BY vwRace.RaceCode
	
		--Ethnicity Wise
		SELECT pa_ethn_type AS Code ,SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		FROM patients pat WITH(NOLOCK)
		INNER JOIN [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] N WITH(NOLOCK) ON pat.pa_id = N.PatientId
		WHERE N.RequestId = @RequestId  AND pa_ethn_type IN (1,2)
		GROUP BY pa_ethn_type
	
		--Gender Wise
	
		SELECT cqm.Code ,SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		FROM patients pat WITH(NOLOCK) 
		INNER JOIN [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] N WITH(NOLOCK) ON pat.pa_id = N.PatientId
		INNER JOIN  [cqm2022].SysLookupCMS147v11_NQF0041 cqm WITH(NOLOCK) ON pat.pa_sex = cqm.Code
		WHERE N.RequestId = @RequestId AND cqm.ValueSetId=12
		GROUP BY cqm.Code,cqm.Description
		 
		--Payer Wise
		 
		SELECT pyr.medicare_type_code AS Code,SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		FROM vwpatientpayers pyr WITH(NOLOCK)
		INNER JOIN [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] N WITH(NOLOCK) ON pyr.pa_id = N.PatientId
		WHERE N.RequestId = @RequestId 
		GROUP BY pyr.medicare_type_code
		 
	END
	
END
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
