SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS155v2_NQF0024_POP1_IPP] 
	-- Add the parameters for the stored procedure here
	@doctorid BIGINT , 
	@fromdate DATETIME ,
	@todate DATETIME ,
	@type INT,
	@agefrom INT = 3,
	@ageto INT = 14
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @type = 1 --Patients
	BEGIN
		SELECT DISTINCT pat.pa_id 
		FROM patients pat INNER JOIN 
		(	SELECT pa_id 
			FROM patient_procedures PP INNER JOIN cqm_codes cqm ON pp.code=cqm.code 
			WHERE cqm.version=2 AND cqm.NQF_id='0024' and cqm.code_type IN ('CPT','SNOMEDCT')
			AND criteriatype='DENOM'  AND cqm.IsActive=1 AND cqm.isexclude=0 AND dr_id=@doctorid
			AND PP.date_performed BETWEEN @fromdate AND @todate
			GROUP BY pa_id HAVING COUNT(pa_id) > 0
		)ppc ON pat.pa_id=PPC.pa_id 
		WHERE DATEDIFF(MONTH,pat.pa_dob,CONVERT(DATETIME,@fromdate,101)) BETWEEN  3*12 AND 17*12
	END
    ELSE IF @type = 2 --All
	BEGIN
		select count(distinct PAT.pa_id)SM from patients PAT 
		inner join (select pa_id from patient_procedures PP
           INNER JOIN CQM_Codes cqm on PP.code=cqm.code 
           where cqm.version=2 AND cqm.NQF_id='0024' and cqm.code_type IN ('CPT','SNOMEDCT')
           and criteriatype='DENOM'  and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid
           AND PP.date_performed between @fromdate AND @todate
           group by pa_id having count(pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id 
           where
           datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) 
           BETWEEN @agefrom*12 AND @ageto*12
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		 select pa_race_type ,COUNT(DISTINCT pat.pa_id) SM from patients PAT inner join (select pa_id from patient_procedures PP
         INNER JOIN CQM_Codes cqm on PP.code=cqm.code where cqm.version=2 AND cqm.NQF_id='0024' and cqm.code_type IN ('CPT','SNOMEDCT')
         and criteriatype='DENOM'  and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid
         AND PP.date_performed between @fromdate AND @todate
         group by pa_id having count(pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id where
         datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN  3*12 AND 17*12 GROUP BY pa_race_type   
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		select pa_ethn_type ,COUNT(DISTINCT pat.pa_id) SM from patients PAT inner join (select pa_id from patient_procedures PP
         INNER JOIN CQM_Codes cqm on PP.code=cqm.code where cqm.version=2 AND cqm.NQF_id='0024' and cqm.code_type IN ('CPT','SNOMEDCT')
         and criteriatype='DENOM'  and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid
         AND PP.date_performed between @fromdate AND @todate
         group by pa_id having count(pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id where
         datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN  3*12 AND 17*12 GROUP BY pa_ethn_type   
	END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		select pa_sex ,COUNT(DISTINCT pat.pa_id) SM from patients PAT inner join (select pa_id from patient_procedures PP
         INNER JOIN CQM_Codes cqm on PP.code=cqm.code where cqm.version=2 AND cqm.NQF_id='0024' and cqm.code_type IN ('CPT','SNOMEDCT')
         and criteriatype='DENOM'  and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid
         AND PP.date_performed between @fromdate AND @todate
         group by pa_id having count(pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id where
         datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN  3*12 AND 17*12 GROUP BY pa_sex   
	END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		select medicare_type_code ,COUNT(DISTINCT pat.pa_id) SM from patients PAT inner join (select pa_id from patient_procedures PP
		INNER JOIN CQM_Codes cqm on PP.code=cqm.code
		where cqm.version=2 AND cqm.NQF_id='0024' and cqm.code_type IN ('CPT','SNOMEDCT')
		and criteriatype='DENOM'  and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid
		AND PP.date_performed between @fromdate AND @todate
		group by pa_id having count(pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id
		INNER JOIN vwpatientpayers pyr ON pat.pa_id = pyr.pa_id
		INNER JOIN cqm_codes cqm_pyr ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
		where
		datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) BETWEEN  3*12 AND 17*12   AND cqm_pyr.version=2 AND cqm_pyr.nqf_id='0024' GROUP BY medicare_type_code   

	END
	SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
