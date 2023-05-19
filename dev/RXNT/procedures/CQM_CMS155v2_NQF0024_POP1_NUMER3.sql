SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS155v2_NQF0024_POP1_NUMER3] 
	-- Add the parameters for the stored procedure here
	@doctorid BIGINT , 
	@fromdate DATETIME ,
	@todate DATETIME ,
	@type INT,
	@agefrom INT = 3,
	@ageto INT = 17
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @type = 2 --All
	BEGIN
		SELECT COUNT(DISTINCT pat.pa_id)SM from patients PAT inner join (select pp.pa_id from patient_procedures PP
		INNER JOIN CQM_Codes cqm on PP.code=cqm.code
		INNER JOIN patient_procedures pp_num ON pp.pa_id=pp_num.pa_id
		INNER JOIN CQM_Codes cqm_num on pp_num.code=cqm_num.code 
		where cqm.version=2 AND cqm.NQF_id='0024'AND cqm.criteriatype='DENOM' and cqm.code_type IN ('CPT','SNOMEDCT') and cqm.IsActive=1 and cqm.IsExclude=0 
		and pp.dr_id= @doctorid
		AND PP.date_performed between @fromdate AND @todate
		AND pp_num.date_performed between @fromdate AND @todate
		AND cqm_num.version=2 AND cqm_num.NQF_id='0024'AND cqm_num.criteriatype='NUM3' and cqm_num.code_type IN ('CPT','SNOMEDCT') and cqm_num.IsActive=1 and cqm_num.IsExclude=0
		group by pp.pa_id having count(pp.pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id where
		datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN @agefrom*12 AND @ageto*12
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		SELECT pa_race_type,COUNT(DISTINCT pat.pa_id) sm from patients PAT inner join (select pp.pa_id from patient_procedures PP
		INNER JOIN CQM_Codes cqm on PP.code=cqm.code
		INNER JOIN patient_procedures pp_num ON pp.pa_id=pp_num.pa_id
		INNER JOIN CQM_Codes cqm_num on pp_num.code=cqm_num.code 
		where cqm.version=2 AND cqm.NQF_id='0024'AND cqm.criteriatype='DENOM' and cqm.code_type IN ('CPT','SNOMEDCT') and cqm.IsActive=1 and cqm.IsExclude=0 
		and pp.dr_id= @doctorid
		AND PP.date_performed between @fromdate AND @todate
		AND pp_num.date_performed between @fromdate AND @todate
		AND cqm_num.version=2 AND cqm_num.NQF_id='0024'AND cqm_num.criteriatype='NUM3' and cqm_num.code_type IN ('CPT','SNOMEDCT') and cqm_num.IsActive=1 and cqm_num.IsExclude=0
		group by pp.pa_id having count(pp.pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id where
		datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN 3*12 AND 17*12 GROUP BY pa_race_type

	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type,COUNT(DISTINCT pat.pa_id) sm from patients PAT inner join (select pp.pa_id from patient_procedures PP
		INNER JOIN CQM_Codes cqm on PP.code=cqm.code
		INNER JOIN patient_procedures pp_num ON pp.pa_id=pp_num.pa_id
		INNER JOIN CQM_Codes cqm_num on pp_num.code=cqm_num.code 
		where cqm.version=2 AND cqm.NQF_id='0024'AND cqm.criteriatype='DENOM' and cqm.code_type IN ('CPT','SNOMEDCT') and cqm.IsActive=1 and cqm.IsExclude=0 
		and pp.dr_id= @doctorid
		AND PP.date_performed between @fromdate AND @todate
		AND pp_num.date_performed between @fromdate AND @todate
		AND cqm_num.version=2 AND cqm_num.NQF_id='0024'AND cqm_num.criteriatype='NUM3' and cqm_num.code_type IN ('CPT','SNOMEDCT') and cqm_num.IsActive=1 and cqm_num.IsExclude=0
		group by pp.pa_id having count(pp.pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id where
		datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN 3*12 AND 17*12 GROUP BY pa_ethn_type
 
	END
	ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex,COUNT(DISTINCT pat.pa_id) sm from patients PAT inner join (select pp.pa_id from patient_procedures PP
		INNER JOIN CQM_Codes cqm on PP.code=cqm.code
		INNER JOIN patient_procedures pp_num ON pp.pa_id=pp_num.pa_id
		INNER JOIN CQM_Codes cqm_num on pp_num.code=cqm_num.code 
		where cqm.version=2 AND cqm.NQF_id='0024'AND cqm.criteriatype='DENOM' and cqm.code_type IN ('CPT','SNOMEDCT') and cqm.IsActive=1 and cqm.IsExclude=0 
		and pp.dr_id= @doctorid
		AND PP.date_performed between @fromdate AND @todate
		AND pp_num.date_performed between @fromdate AND @todate
		AND cqm_num.version=2 AND cqm_num.NQF_id='0024'AND cqm_num.criteriatype='NUM3' and cqm_num.code_type IN ('CPT','SNOMEDCT') and cqm_num.IsActive=1 and cqm_num.IsExclude=0
		group by pp.pa_id having count(pp.pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id where
		datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN 3*12 AND 17*12 GROUP BY pa_sex

	END
	ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) sm from patients PAT inner join (select pp.pa_id from patient_procedures PP
		INNER JOIN CQM_Codes cqm on PP.code=cqm.code
		INNER JOIN patient_procedures pp_num ON pp.pa_id=pp_num.pa_id
		INNER JOIN CQM_Codes cqm_num on pp_num.code=cqm_num.code 
		where cqm.version=2 AND cqm.NQF_id='0024'AND cqm.criteriatype='DENOM' and cqm.code_type IN ('CPT','SNOMEDCT') and cqm.IsActive=1 and cqm.IsExclude=0 
		and pp.dr_id= @doctorid
		AND PP.date_performed between @fromdate AND @todate
		AND pp_num.date_performed between @fromdate AND @todate
		AND cqm_num.version=2 AND cqm_num.NQF_id='0024'AND cqm_num.criteriatype='NUM3' and cqm_num.code_type IN ('CPT','SNOMEDCT') and cqm_num.IsActive=1 and cqm_num.IsExclude=0
		group by pp.pa_id having count(pp.pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id
		INNER JOIN vwpatientpayers pyr ON pat.pa_id = pyr.pa_id
		INNER JOIN cqm_codes cqm_pyr ON pyr.medicare_type_code=cqm_pyr.code 
		where cqm_pyr.version=2 AND cqm_pyr.nqf_id='0024' AND
		datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN 3*12 AND 17*12 
		GROUP BY medicare_type_code
 
	END
	SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
