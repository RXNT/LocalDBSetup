SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS68v3_NQF0419_POP1_NUMER] 
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
		select count(distinct procedure_id) SM from 
		(
		select pp.procedure_id procedure_id FROM patients pat with(nolock)
			INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id 
			INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
			inner join patient_active_meds PAM with(nolock) on PAT.pa_id = PAM.pa_id 
			AND (PAM.last_modified_date is null or PAM.last_modified_date < @todate)
			WHERE 
			cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type='CPT' 
			AND cqm.criteriatype='POP1' AND cqm.isactive=1 AND cqm.isexclude=0 
			AND pp.dr_id = @doctorid AND pp.date_performed BETWEEN @fromdate AND @todate 
			AND DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12 
			group by pp.procedure_id
		UNION
			select pp.procedure_id procedure_id FROM patients pat with(nolock)
				INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id 
				INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
				inner join patient_procedures PAM with(nolock) on PAT.pa_id = PAM.pa_id
				inner join cqm_codes cqm_num1 with(nolock) ON PAM.code=cqm_num1.code
					AND cqm_num1.code_type = 'SNOMEDCT' AND cqm_num1.criteriatype = 'NUM1'
					AND cqm_num1.NQF_id='0419' 
				WHERE 
				cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type='CPT' 
				AND cqm.criteriatype='POP1' AND cqm.isactive=1 AND cqm.isexclude=0 
				AND pp.dr_id = @doctorid 
				AND pp.date_performed BETWEEN @fromdate AND @todate
				AND PAM.date_performed <= pp.date_performed
				AND DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12 
				group by pp.procedure_id
		)PR
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		SELECT pa_race_type,COUNT(DISTINCT pat.pa_id) sm FROM 
		patients pat  with(nolock) 
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id  
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
        LEFT OUTER JOIN patient_active_meds AM with(nolock) on pat.pa_id=am.pa_id
        LEFT OUTER JOIN  patient_procedures pp_num1 with(nolock) ON pat.pa_id=pp_num1.pa_id
        LEFT OUTER JOIN cqm_codes cqm_num1 with(nolock) ON pp_num1.code=cqm_num1.code
				AND cqm_num1.code_type = 'SNOMEDCT' AND cqm_num1.criteriatype = 'NUM1' 
        WHERE cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype = 'POP1'
			AND cqm.isactive=1 AND cqm.isexclude=0 AND pp.dr_id = @doctorid
			AND pp.date_performed BETWEEN @fromdate AND @todate
			AND DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12 
			AND not(pa_race_type is null)
			AND
			((pp_num1.date_performed BETWEEN pp.date_performed AND ISNULL(pp.date_performed_to,pp.date_performed) AND pp_num1.type='Procedure'  
				AND pp_num1.status='Completed') OR (not(AM.pam_id is null)))
        GROUP BY pa_race_type
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type,COUNT(DISTINCT pat.pa_id) sm 
		FROM 
		patients pat  with(nolock) 
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id  
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
        LEFT OUTER JOIN patient_active_meds AM with(nolock) on pat.pa_id=am.pa_id
        LEFT OUTER JOIN  patient_procedures pp_num1 with(nolock) ON pat.pa_id=pp_num1.pa_id
        LEFT OUTER JOIN cqm_codes cqm_num1 with(nolock) ON pp_num1.code=cqm_num1.code
				AND cqm_num1.code_type = 'SNOMEDCT' AND cqm_num1.criteriatype = 'NUM1' 
        WHERE cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype = 'POP1'
			AND cqm.isactive=1 AND cqm.isexclude=0 AND pp.dr_id = @doctorid
			AND pp.date_performed BETWEEN @fromdate AND @todate
			AND DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12
			AND not(pa_ethn_type is null)
			AND
			((pp_num1.date_performed BETWEEN pp.date_performed AND ISNULL(pp.date_performed_to,pp.date_performed) AND pp_num1.type='Procedure'  
				AND pp_num1.status='Completed') OR (not(AM.pam_id is null)))
        GROUP BY pa_ethn_type
    END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex,COUNT(DISTINCT pat.pa_id) sm 
		FROM 
		patients pat  with(nolock) 
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id  
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
        LEFT OUTER JOIN patient_active_meds AM with(nolock) on pat.pa_id=am.pa_id
        LEFT OUTER JOIN  patient_procedures pp_num1 with(nolock) ON pat.pa_id=pp_num1.pa_id
        LEFT OUTER JOIN cqm_codes cqm_num1 with(nolock) ON pp_num1.code=cqm_num1.code
				AND cqm_num1.code_type = 'SNOMEDCT' AND cqm_num1.criteriatype = 'NUM1' 
        WHERE cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype = 'POP1'
			AND cqm.isactive=1 AND cqm.isexclude=0 AND pp.dr_id = @doctorid
			AND pp.date_performed BETWEEN @fromdate AND @todate
			AND DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12 
			AND not(pa_sex is null)
			AND
			((pp_num1.date_performed BETWEEN pp.date_performed AND ISNULL(pp.date_performed_to,pp.date_performed) AND pp_num1.type='Procedure'  
				AND pp_num1.status='Completed') OR (not(AM.pam_id is null)))
       GROUP BY pa_sex
    END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) sm 
		FROM patients pat with(nolock) 
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id  
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
		LEFT OUTER JOIN patient_active_meds AM with(nolock) on pat.pa_id=am.pa_id
		LEFT OUTER JOIN  patient_procedures pp_num1 with(nolock) ON pat.pa_id=pp_num1.pa_id
		LEFT OUTER JOIN cqm_codes cqm_num1 with(nolock) ON pp_num1.code=cqm_num1.code 
				AND cqm_num1.code_type = 'SNOMEDCT' AND cqm_num1.criteriatype = 'NUM1' 
		INNER JOIN vwpatientpayers pyr with(nolock) ON pat.pa_id = pyr.pa_id 
		INNER JOIN cqm_codes cqm_pyr with(nolock) ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
		WHERE 
		cqm_pyr.version=2 AND cqm_pyr.nqf_id='0419' AND cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype = 'POP1'
		AND cqm.isactive=1 AND cqm.isexclude=0 AND pp.dr_id = @doctorid
		AND pp.date_performed BETWEEN @fromdate AND @todate
		AND DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12 
		AND not(medicare_type_code is null)
		AND
        ((pp_num1.date_performed BETWEEN pp.date_performed AND ISNULL(pp.date_performed_to,pp.date_performed) AND pp_num1.type='Procedure'  
			AND pp_num1.status='Completed') OR (not(AM.pam_id is null)))
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
