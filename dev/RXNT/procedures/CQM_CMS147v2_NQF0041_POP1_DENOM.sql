SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS147v2_NQF0041_POP1_DENOM] 
	-- Add the parameters for the stored procedure here
	@doctorid BIGINT , 
	@fromdate DATETIME ,
	@todate DATETIME ,
	@type INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @type = 2 --All
	BEGIN
		  select count(distinct PAT.pa_id)SM from patients PAT 
		  inner join
          (
			(select pa_id from patient_procedures PP 
				INNER JOIN CQM_Codes cqm on PP.code=cqm.code
				where cqm.version=2 AND cqm.NQF_id='0041' 
				and cqm.code_type='CPT' and criteriatype='POP1' 
				and criteria=1
				and cqm.IsActive=1 and cqm.IsExclude=0 
				and dr_id= @doctorid 
				AND (PP.date_performed between @fromdate AND @todate)
				group by pa_id having count(pa_id) >= 2
			) 
			union 
			(select pa_id from patient_procedures PP 
				INNER JOIN CQM_Codes cqm on PP.code=cqm.code
				where cqm.version=2 AND cqm.NQF_id='0041' 
				and cqm.code_type='CPT' 
				and (
						(criteriatype='POP1' and criteria=2) 
						OR (criteriatype='Common1' and criteria IN (1,2))
					)
				and cqm.IsActive=1 and cqm.IsExclude=0 
				and dr_id= @doctorid 
				AND PP.date_performed between @fromdate AND @todate
				group by pa_id having count(pa_id) >= 1
			  )
		  )PPC on PAT.pa_id=PPC.pa_id 
		  inner join patient_procedures PP on PAT.pa_id=PP.pa_id
          where datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 6 
          and not (pa_dob like '1901-01-01') 
          AND PP.date_performed between DATEADD(d,-92,@fromdate) 
				AND DATEADD(d,91,@fromdate) 
          AND PP.CODE in 
			(select code from CQM_Codes where 
				version=2 
				AND NQF_id='0041' and  code_type='CPT'
				and IsActive = 1 and criteria IN (2,3,4) and criteriatype = 'Common1'
			)
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		select pa_race_type ,COUNT(DISTINCT pat.pa_id) SM from patients PAT inner join
          ((select pa_id from patient_procedures PP INNER JOIN CQM_Codes cqm on PP.code=cqm.code
          where cqm.version=2 AND cqm.NQF_id='0041' and cqm.code_type='CPT' and criteriatype='POP1' and criteria=1
          and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid AND ((PP.date_performed between
          @fromdate AND @todate))
          group by pa_id having count(pa_id) >= 2) union (select pa_id from patient_procedures PP INNER JOIN CQM_Codes cqm on PP.code=cqm.code
          where cqm.version=2 AND cqm.NQF_id='0041' and cqm.code_type='CPT' and ((criteriatype='POP1' and criteria=2) OR (criteriatype='Common1' and criteria IN (1,2)))
          and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid AND PP.date_performed between
          @fromdate AND @todate
          group by pa_id having count(pa_id) >= 1))PPC on PAT.pa_id=PPC.pa_id inner join patient_procedures PP on PAT.pa_id=PP.pa_id
          where datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 6 and
           not (pa_dob like '1901-01-01') AND PP.date_performed between
          @fromdate AND @todate AND PP.CODE in (select code from CQM_Codes where version=2 AND NQF_id='0041' and  code_type='CPT'
          and IsActive = 1 and criteria IN (2,3,4) and criteriatype = 'Common1')
             GROUP BY pa_race_type
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		 select pa_ethn_type ,COUNT(DISTINCT pat.pa_id) SM from patients PAT inner join
    ((select pa_id from patient_procedures PP INNER JOIN CQM_Codes cqm on PP.code=cqm.code
    where cqm.version=2 AND cqm.NQF_id='0041' and cqm.code_type='CPT' and criteriatype='POP1' and criteria=1
    and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid AND ((PP.date_performed between
    @fromdate AND @todate))
    group by pa_id having count(pa_id) >= 2) union (select pa_id from patient_procedures PP INNER JOIN CQM_Codes cqm on PP.code=cqm.code
    where cqm.version=2 AND cqm.NQF_id='0041' and cqm.code_type='CPT' and ((criteriatype='POP1' and criteria=2) OR (criteriatype='Common1' and criteria IN (1,2)))
    and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid AND PP.date_performed between
    @fromdate AND @todate
    group by pa_id having count(pa_id) >= 1))PPC on PAT.pa_id=PPC.pa_id inner join patient_procedures PP on PAT.pa_id=PP.pa_id
    where datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 6 and
     not (pa_dob like '1901-01-01') AND PP.date_performed between
    @fromdate AND @todate AND PP.CODE in (select code from CQM_Codes where version=2 AND NQF_id='0041' and  code_type='CPT'
    and IsActive = 1 and criteria IN (2,3,4) and criteriatype = 'Common1')
       GROUP BY pa_ethn_type
	END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		select pa_sex ,COUNT(DISTINCT pat.pa_id) SM from patients PAT inner join
    ((select pa_id from patient_procedures PP INNER JOIN CQM_Codes cqm on PP.code=cqm.code
    where cqm.version=2 AND cqm.NQF_id='0041' and cqm.code_type='CPT' and criteriatype='POP1' and criteria=1
    and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid AND ((PP.date_performed between
    @fromdate AND @todate))
    group by pa_id having count(pa_id) >= 2) union (select pa_id from patient_procedures PP INNER JOIN CQM_Codes cqm on PP.code=cqm.code
    where cqm.version=2 AND cqm.NQF_id='0041' and cqm.code_type='CPT' and ((criteriatype='POP1' and criteria=2) OR (criteriatype='Common1' and criteria IN (1,2)))
    and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid AND PP.date_performed between
    @fromdate AND @todate
    group by pa_id having count(pa_id) >= 1))PPC on PAT.pa_id=PPC.pa_id inner join patient_procedures PP on PAT.pa_id=PP.pa_id
    where datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 6 and
     not (pa_dob like '1901-01-01') AND PP.date_performed between
    @fromdate AND @todate AND PP.CODE in (select code from CQM_Codes where version=2 AND NQF_id='0041' and  code_type='CPT'
    and IsActive = 1 and criteria IN (2,3,4) and criteriatype = 'Common1')
       GROUP BY pa_sex
	END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		select medicare_type_code ,COUNT(DISTINCT pat.pa_id) SM from patients PAT inner join
    ((select pa_id from patient_procedures PP INNER JOIN CQM_Codes cqm on PP.code=cqm.code
    where cqm.version=2 AND cqm.NQF_id='0041' and cqm.code_type='CPT' and criteriatype='POP1' and criteria=1
    and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid AND ((PP.date_performed between
    @fromdate AND @todate))
    group by pa_id having count(pa_id) >= 2) union (select pa_id from patient_procedures PP INNER JOIN CQM_Codes cqm on PP.code=cqm.code
    where cqm.version=2 AND cqm.NQF_id='0041' and cqm.code_type='CPT' and ((criteriatype='POP1' and criteria=2) OR (criteriatype='Common1' and criteria IN (1,2)))
    and cqm.IsActive=1 and cqm.IsExclude=0 and dr_id= @doctorid AND PP.date_performed between
    @fromdate AND @todate
    group by pa_id having count(pa_id) >= 1))PPC on PAT.pa_id=PPC.pa_id inner join patient_procedures PP on PAT.pa_id=PP.pa_id
    INNER JOIN vwpatientpayers pyr ON pat.pa_id = pyr.pa_id
    INNER JOIN cqm_codes cqm_pyr ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
    where  cqm_pyr.version=2 AND cqm_pyr.nqf_id='0041' AND datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 6 and
     not (pa_dob like '1901-01-01') AND PP.date_performed between
    @fromdate AND @todate AND PP.CODE in (select code from CQM_Codes where version=2 AND NQF_id='0041' and  code_type='CPT'
    and IsActive = 1 and criteria IN (2,3,4) and criteriatype = 'Common1')
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
