SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS69v2_NQF0421_POP1_DENEX] 
	-- Add the parameters for the stored procedure here
	@doctorid BIGINT , 
	@fromdate DATETIME ,
	@todate DATETIME ,
	@type INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @type = 2 --All
	BEGIN
		SELECT COUNT(DISTINCT PAT.pa_id) AS SM
		FROM patients PAT WITH(NOLOCK) INNER JOIN
        (	SELECT PP.pa_id
			FROM 
			patients PAT WITH(NOLOCK)
			INNER JOIN patient_procedures PP WITH(NOLOCK) ON PAT.pa_id = PP.PA_ID
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_active_diagnosis pad WITH(NOLOCK) ON PP.pa_id = pad.pa_id
			INNER JOIN  CQM_Codes cqm_ex WITH(NOLOCK) ON 
			(cqm_ex.code=pad.icd9 or cqm_ex.code = PAD.icd10)
			WHERE 
			cqm.version=2 AND cqm.NQF_id='0421' 
			AND cqm.code_type IN ('CPT','SNOMEDCT') 
			AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 
			AND pp.dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND cqm_ex.version=2 AND cqm_ex.NQF_id='0421' 
			and cqm_ex.code_type IN ('ICD9CM','ICD10CM') 
			and cqm_ex.criteriatype='Common1' and cqm_ex.criteria = 3 
			and	cqm_ex.IsExclude=1  AND cqm_ex.IsActive=1
			AND (PAD.onset IS NULL OR pad.onset BETWEEN DATEADD(M,-6,@fromdate) AND @todate)
			UNION
			SELECT PP.pa_id
			FROM 
			patients PAT WITH(NOLOCK)
			INNER JOIN patient_procedures PP WITH(NOLOCK) ON PAT.pa_id = PP.PA_ID
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_flag_details pfd WITH(NOLOCK) ON PP.pa_id = pfd.pa_id
			WHERE 
			cqm.version=2 AND cqm.NQF_id='0421' 
			AND cqm.code_type IN ('CPT','SNOMEDCT') 
			AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 
			AND PP.dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND flag_id in (14,15)
		)PPC ON PAT.pa_id=PPC.pa_id
		WHERE DATEDIFF(MONTH,PAT.pa_dob, @fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01')
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
        SELECT pa_race_type ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT WITH(NOLOCK) INNER JOIN
        (	SELECT PP.pa_id
			FROM patient_procedures PP WITH(NOLOCK)
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_active_diagnosis pad WITH(NOLOCK) ON PP.pa_id = pad.pa_id
			INNER JOIN  CQM_Codes cqm_ex WITH(NOLOCK) ON cqm_ex.code=icd9
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND cqm_ex.version=2 AND cqm_ex.NQF_id='0421' and cqm_ex.code_type IN ('ICD9CM','ICD10CM') and cqm_ex.criteriatype='Common1' and cqm_ex.criteria = 3 and				cqm_ex.IsExclude=1  AND cqm_ex.IsActive=1
			UNION
			SELECT PP.pa_id
			FROM patient_procedures PP WITH(NOLOCK) 
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_flag_details pfd WITH(NOLOCK) ON PP.pa_id = pfd.pa_id
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND PP.dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND flag_id in (14,15)
		)PPC ON PAT.pa_id=PPC.pa_id
		WHERE DATEDIFF(MONTH,PAT.pa_dob, @fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01') 
        GROUP BY pa_race_type
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT WITH(NOLOCK) INNER JOIN
        (	SELECT PP.pa_id
			FROM patient_procedures PP WITH(NOLOCK) 
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_active_diagnosis pad WITH(NOLOCK) ON PP.pa_id = pad.pa_id
			INNER JOIN  CQM_Codes cqm_ex WITH(NOLOCK) ON cqm_ex.code=icd9
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND cqm_ex.version=2 AND cqm_ex.NQF_id='0421' and cqm_ex.code_type IN ('ICD9CM','ICD10CM') and cqm_ex.criteriatype='Common1' and cqm_ex.criteria = 3 and				cqm_ex.IsExclude=1  AND cqm_ex.IsActive=1
			UNION
			SELECT PP.pa_id
			FROM patient_procedures PP WITH(NOLOCK) 
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_flag_details pfd WITH(NOLOCK) ON PP.pa_id = pfd.pa_id
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND PP.dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND flag_id in (14,15)
		)PPC ON PAT.pa_id=PPC.pa_id
		WHERE DATEDIFF(MONTH,PAT.pa_dob, @fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01') 
		GROUP BY pa_ethn_type
    END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex ,COUNT(DISTINCT pat.pa_id) SM  
		FROM patients PAT WITH(NOLOCK) INNER JOIN
        (	SELECT PP.pa_id
			FROM patient_procedures PP WITH(NOLOCK) 
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_active_diagnosis pad WITH(NOLOCK) ON PP.pa_id = pad.pa_id
			INNER JOIN  CQM_Codes cqm_ex WITH(NOLOCK) ON cqm_ex.code=icd9
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND cqm_ex.version=2 AND cqm_ex.NQF_id='0421' and cqm_ex.code_type IN ('ICD9CM','ICD10CM') and cqm_ex.criteriatype='Common1' and cqm_ex.criteria = 3 and				cqm_ex.IsExclude=1  AND cqm_ex.IsActive=1
			UNION
			SELECT PP.pa_id
			FROM patient_procedures PP WITH(NOLOCK) 
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_flag_details pfd WITH(NOLOCK) ON PP.pa_id = pfd.pa_id
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND PP.dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND flag_id in (14,15)
		)PPC ON PAT.pa_id=PPC.pa_id
		WHERE DATEDIFF(MONTH,PAT.pa_dob, @fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01') 
        GROUP BY pa_sex
    END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT WITH(NOLOCK) INNER JOIN
        (	SELECT PP.pa_id
			FROM patient_procedures PP WITH(NOLOCK) 
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_active_diagnosis pad WITH(NOLOCK) ON PP.pa_id = pad.pa_id
			INNER JOIN  CQM_Codes cqm_ex ON cqm_ex.code=icd9
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND cqm_ex.version=2 AND cqm_ex.NQF_id='0421' and cqm_ex.code_type IN ('ICD9CM','ICD10CM') and cqm_ex.criteriatype='Common1' and cqm_ex.criteria = 3 and				cqm_ex.IsExclude=1  AND cqm_ex.IsActive=1
			UNION
			SELECT PP.pa_id
			FROM patient_procedures PP WITH(NOLOCK)
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code
			INNER JOIN  patient_flag_details pfd WITH(NOLOCK) ON PP.pa_id = pfd.pa_id
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND cqm.criteriatype='Common1' AND cqm.criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND PP.dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			AND flag_id in (14,15)
		)PPC ON PAT.pa_id=PPC.pa_id
		INNER JOIN vwpatientpayers pyr WITH(NOLOCK) ON pat.pa_id = pyr.pa_id
        INNER JOIN cqm_codes cqm_pyr WITH(NOLOCK) ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
		WHERE DATEDIFF(MONTH,PAT.pa_dob, @fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01') 
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
