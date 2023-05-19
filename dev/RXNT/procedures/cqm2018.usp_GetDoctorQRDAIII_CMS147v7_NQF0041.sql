SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 01-May-2018
-- Description:	To get the Doctor CQM request status 
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_GetDoctorQRDAIII_CMS147v7_NQF0041]  
	@DoctorId BIGINT,	
	@StartDate Date,
	@EndDate Date	
AS
BEGIN

	 DECLARE @RequestId BIGINT
	 SELECT @RequestId = MAX(RequestId) FROM  [cqm2018].[DoctorCQMCalculationRequest] R WITH(NOLOCK)
	 WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1
	 IF @RequestId>0
	 BEGIN
		 /*Complete*/
		 SELECT 
		 SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		 SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		 SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		 SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		 SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		 SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		 FROM  [cqm2018].[DoctorCQMCalcPop1CMS147v7_NQF0041] N WITH(NOLOCK)
		 WHERE N.RequestId = @RequestId 
		 
		 --Race Wise
		 
		SELECT 
		vwRace.RaceId AS Code,
		vwRace.Description as Description,
		SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		FROM patients pat WITH(NOLOCK) 
		INNER JOIN [cqm2018].[DoctorCQMCalcPop1CMS147v7_NQF0041] N WITH(NOLOCK) ON pat.pa_id = N.PatientId
		INNER JOIN cqm2018.vwRaceCodes vwRace WITH(NOLOCK) ON pat.pa_race_type & vwRace.RaceId=vwRace.RaceId
		WHERE N.RequestId = @RequestId AND vwRace.RaceId>0
		GROUP BY vwRace.RaceId,vwRace.Description
	
		--Ethnicity Wise
		SELECT 
		vwEthnicity.EthnicityCode AS Code ,
		vwEthnicity.Description,
		SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		FROM patients pat WITH(NOLOCK)
		INNER JOIN [cqm2018].[DoctorCQMCalcPop1CMS147v7_NQF0041] N WITH(NOLOCK) ON pat.pa_id = N.PatientId
		RIGHT OUTER JOIN cqm2018.[vwEthnicityCodes] vwEthnicity WITH(NOLOCK) ON pat.pa_ethn_type =vwEthnicity.EthnicityId
		WHERE N.RequestId = @RequestId AND pa_ethn_type IN (1,2)
		GROUP BY vwEthnicity.EthnicityCode,vwEthnicity.Description
	
		--Gender Wise
	
		SELECT 
		cqm.Code,
		cqm.Description,
		SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		FROM patients pat WITH(NOLOCK) 
		INNER JOIN [cqm2018].[DoctorCQMCalcPop1CMS147v7_NQF0041] N WITH(NOLOCK) ON pat.pa_id = N.PatientId
		INNER JOIN  [cqm2018].SysLookupCMS147v7_NQF0041 cqm WITH(NOLOCK) ON pat.pa_sex = cqm.Code
		WHERE N.RequestId = @RequestId AND cqm.ValueSetId=3
		GROUP BY cqm.Code,cqm.Description
		 
		--Payer Wise
		 
		SELECT 
		pyr.medicare_type_code AS Code,
		pyr.medicare_type_code AS Description,
		SUM(CASE WHEN N.IPP = 1 THEN 1 ELSE 0 END) as IPP, 
		SUM(CASE WHEN N.Denominator = 1 THEN 1 ELSE 0 END) as Denominator, 
		SUM(CASE WHEN N.DenomExclusions = 1 THEN 1 ELSE 0 END) as DenomExclusions,
		SUM(CASE WHEN N.Numerator = 1 THEN 1 ELSE 0 END) as Numerator,
		SUM(CASE WHEN N.NumerExclusions = 1 THEN 1 ELSE 0 END) as NumerExclusions,
		SUM(CASE WHEN N.DenomExceptions = 1 THEN 1 ELSE 0 END) as DenomExceptions
		FROM vwpatientpayers pyr WITH(NOLOCK)
		INNER JOIN [cqm2018].[DoctorCQMCalcPop1CMS147v7_NQF0041] N WITH(NOLOCK) ON pyr.pa_id = N.PatientId
		WHERE N.RequestId = @RequestId   AND medicare_type_code!='' AND medicare_type_code IS NOT NULL
		GROUP BY pyr.medicare_type_code
		 
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
