SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS117v2_NQF0038_POP1_NUMER] 
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
		SELECT COUNT(DISTINCT PAT.pa_id) SM 
		--Common
		FROM patients pat WITH(NOLOCK)
        INNER JOIN (
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id 
	        FROM tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id 
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK)
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX' 
	        AND cqm_num1_1.criteriatype='NUM1' AND cqm_num1_1.criteria=1   
	        WHERE  cqm_num1_1.version=2 
	        group by vacr_num1_1.vac_pat_id 
	        having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat WITH(NOLOCK) 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK)
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=1   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id 
	        having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM 
	        patients pat WITH(NOLOCK) 
	        INNER JOIN patient_active_diagnosis pad_num1_3 WITH(NOLOCK) ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK)
	        on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=3   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id) 
	        NUM1 ON NUM1.pa_id=pat.pa_id 
			INNER JOIN 
	        (
	        SELECT DISTINCT(PAT.pa_id)  FROM 
	        patients pat WITH(NOLOCK) 
	        INNER JOIN tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_pat_id = PAT.pa_id 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK)
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM2' AND cqm_num1_1.criteria=1   
	        WHERE cqm_num1_1.version=2 
	        group by PAT.pa_id 
	        having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM 
	        patients pat WITH(NOLOCK) 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK)
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=1   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id 
	        having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM 
	        patients pat WITH(NOLOCK) 
	        INNER JOIN patient_active_diagnosis pad_num1_3 WITH(NOLOCK) ON pat.pa_id=pad_num1_3.pa_id
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK)
	        on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=3   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id
	        ) NUM2  ON NUM2.pa_id=pat.pa_id
			INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM 
	        tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK)
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM3' AND cqm_num1_1.criteria=1   
	        WHERE cqm_num1_1.version=2 
	        group by vacr_num1_1.vac_pat_id 
	        ) NUM3  ON NUM3.pa_id=pat.pa_id
			INNER JOIN(
	        SELECT DISTINCT(pat.pa_id) AS pa_id  FROM 
	        patients pat WITH(NOLOCK) 
	        INNER JOIN patient_active_diagnosis pad_num1_3 WITH(NOLOCK) ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK)
	        on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=1   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id
	        UNION 
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM 
	        tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK)
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM4' AND cqm_num1_1.criteria=2   
	        WHERE cqm_num1_1.version=2 
	        group by vacr_num1_1.vac_pat_id 
	        having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM 
	        patients pat WITH(NOLOCK) 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK)
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=3   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id 
	        having count(pp_num1_2.code) >= 3
	        ) NUM4  ON NUM4.pa_id=pat.pa_id
			INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id 
	        FROM tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK) 
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM5' AND cqm_num1_1.criteria=1   
	        WHERE cqm_num1_1.version=2 
	        group by vacr_num1_1.vac_pat_id 
	        having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK) 
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM5' AND cqm_num1_2.criteria=2   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id 
	        having count(pp_num1_2.code) >= 3
	        ) NUM5   ON NUM5.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id 
	        FROM tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK) 
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM6' AND cqm_num1_1.criteria=1   
	        WHERE cqm_num1_1.version=2 
	        group by vacr_num1_1.vac_pat_id  
            UNION 
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat WITH(NOLOCK) 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK) 
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM6' AND cqm_num1_2.criteria=2   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id  
	        ) NUM6   ON NUM6.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat WITH(NOLOCK) 
	        INNER JOIN patient_active_diagnosis pad_num1_3 WITH(NOLOCK) ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK) 
	        on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=1   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id 
	        FROM tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK) 
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM7' AND cqm_num1_1.criteria=2   
	        WHERE cqm_num1_1.version=2 
	        group by vacr_num1_1.vac_pat_id 
	        having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat WITH(NOLOCK) 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK) 
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=3   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id 
	        having count(pp_num1_2.code) >= 4
	        ) NUM7   ON NUM7.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id 
	        FROM tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK) 
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM8' AND cqm_num1_1.criteria=1   
	        WHERE cqm_num1_1.version=2 
	        group by vacr_num1_1.vac_pat_id  
	        UNION
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat WITH(NOLOCK) 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK) 
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM8' AND cqm_num1_2.criteria=2   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id  
	        ) NUM8   ON NUM8.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat WITH(NOLOCK) 
	        INNER JOIN patient_active_diagnosis pad_num1_3 WITH(NOLOCK) ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK) 
	        on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria=1   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id 
	        FROM tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK) 
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM9' AND cqm_num1_1.criteria IN (2,4)  
	        WHERE cqm_num1_1.version=2 
	        group by vacr_num1_1.vac_pat_id 
	        having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat WITH(NOLOCK) 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK) 
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria IN (3,5)  
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id 
	        having count(pp_num1_2.code) >= 2
        ) NUM9   ON NUM9.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id 
	        FROM tblvaccinationrecord vacr_num1_1 WITH(NOLOCK) 
	        INNER JOIN tblVaccines vac_num1_1 WITH(NOLOCK) on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 WITH(NOLOCK) 
	        on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM10' AND cqm_num1_1.criteria=1   
	        WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  
	        FROM patients pat WITH(NOLOCK) 
	        INNER JOIN patient_procedures pp_num1_2 WITH(NOLOCK) on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 WITH(NOLOCK) 
	        on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM10' AND cqm_num1_2.criteria = 2   
	        WHERE cqm_num1_2.version=2 
	        group by PAT.pa_id 
	        having count(pp_num1_2.code) >= 2
	        ) NUM10   ON NUM10.pa_id=pat.pa_id  
	    --Common
		
		INNER JOIN PATIENT_PROCEDURES PP WITH(NOLOCK) ON PAT.PA_ID=PP.PA_ID 
		INNER JOIN  CQM_Codes cqm WITH(NOLOCK) ON PP.CODE=cqm.CODE
		WHERE cqm.version=2 AND PP.DR_ID=@doctorid AND date_performed between @fromdate AND @todate AND nqf_id='0038'
		AND cqm.isactive=1 AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype='POP1'
		AND DATEDIFF(MONTH,PAT.pa_dob,CONVERT(DATETIME,@fromdate,101)) >= 1*12 AND   DATEDIFF(MONTH,PAT.pa_dob,@fromdate)  <= 2*12 AND not (pa_dob like '1901-01-01')
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		SELECT pa_race_type ,COUNT(DISTINCT pat.pa_id) SM
		--Common
		FROM patients pat
        INNER JOIN (
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id 
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX' 
	        AND cqm_num1_1.criteriatype='NUM1' AND cqm_num1_1.criteria=1   WHERE  cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id) NUM1 ON NUM1.pa_id=pat.pa_id 
        INNER JOIN 
	        (
	        SELECT DISTINCT(PAT.pa_id)  FROM patients pat INNER JOIN tblvaccinationrecord vacr_num1_1 on vacr_num1_1.vac_pat_id = PAT.pa_id INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM2' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by PAT.pa_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        ) NUM2  ON NUM2.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM3' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id 
	        ) NUM3  ON NUM3.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id) AS pa_id  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION 
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM4' AND cqm_num1_1.criteria=2   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        ) NUM4  ON NUM4.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM5' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM5' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        ) NUM5   ON NUM5.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM6' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id  
            UNION 
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM6' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id  
	        ) NUM6   ON NUM6.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM7' AND cqm_num1_1.criteria=2   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 4
	        ) NUM7   ON NUM7.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM8' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id  
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM8' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id  
	        ) NUM8   ON NUM8.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM9' AND cqm_num1_1.criteria IN (2,4)   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria IN (3,5)   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 2
        ) NUM9   ON NUM9.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM10' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM10' AND cqm_num1_2.criteria = 2   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 2
	        ) NUM10   ON NUM10.pa_id=pat.pa_id  
	    --Common
		
		INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID INNER JOIN  CQM_Codes cqm ON PP.CODE=cqm.CODE
		WHERE cqm.version=2 AND PP.DR_ID=@doctorid AND date_performed between @fromdate AND @todate AND nqf_id='0038'
		AND cqm.isactive=1 AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype='POP1'
		AND DATEDIFF(MONTH,PAT.pa_dob,CONVERT(DATETIME,@fromdate,101)) >= 1*12 AND   DATEDIFF(MONTH,PAT.pa_dob,@fromdate)  <= 2*12 AND not (pa_dob like '1901-01-01')
		GROUP BY pa_race_type
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type ,COUNT(DISTINCT pat.pa_id) SM
		--Common
		FROM patients pat
        INNER JOIN (
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id 
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX' 
	        AND cqm_num1_1.criteriatype='NUM1' AND cqm_num1_1.criteria=1   WHERE  cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id) NUM1 ON NUM1.pa_id=pat.pa_id 
        INNER JOIN 
	        (
	        SELECT DISTINCT(PAT.pa_id)  FROM patients pat INNER JOIN tblvaccinationrecord vacr_num1_1 on vacr_num1_1.vac_pat_id = PAT.pa_id INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM2' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by PAT.pa_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        ) NUM2  ON NUM2.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM3' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id 
	        ) NUM3  ON NUM3.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id) AS pa_id  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION 
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM4' AND cqm_num1_1.criteria=2   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        ) NUM4  ON NUM4.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM5' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM5' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        ) NUM5   ON NUM5.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM6' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id  
            UNION 
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM6' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id  
	        ) NUM6   ON NUM6.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM7' AND cqm_num1_1.criteria=2   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 4
	        ) NUM7   ON NUM7.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM8' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id  
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM8' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id  
	        ) NUM8   ON NUM8.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM9' AND cqm_num1_1.criteria IN (2,4)   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria IN (3,5)   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 2
        ) NUM9   ON NUM9.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM10' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM10' AND cqm_num1_2.criteria = 2   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 2
	        ) NUM10   ON NUM10.pa_id=pat.pa_id  
	    --Common
		
		INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID INNER JOIN  CQM_Codes cqm ON PP.CODE=cqm.CODE
		WHERE cqm.version=2 AND PP.DR_ID=@doctorid AND date_performed between @fromdate AND @todate AND nqf_id='0038'
		AND cqm.isactive=1 AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype='POP1'
		AND DATEDIFF(MONTH,PAT.pa_dob,CONVERT(DATETIME,@fromdate,101)) >= 1*12 AND   DATEDIFF(MONTH,PAT.pa_dob,@fromdate)  <= 2*12 AND not (pa_dob like '1901-01-01')
		GROUP BY pa_ethn_type
	END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex ,COUNT(DISTINCT pat.pa_id) SM
		--Common
		FROM patients pat
        INNER JOIN (
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id 
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX' 
	        AND cqm_num1_1.criteriatype='NUM1' AND cqm_num1_1.criteria=1   WHERE  cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id) NUM1 ON NUM1.pa_id=pat.pa_id 
        INNER JOIN 
	        (
	        SELECT DISTINCT(PAT.pa_id)  FROM patients pat INNER JOIN tblvaccinationrecord vacr_num1_1 on vacr_num1_1.vac_pat_id = PAT.pa_id INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM2' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by PAT.pa_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        ) NUM2  ON NUM2.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM3' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id 
	        ) NUM3  ON NUM3.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id) AS pa_id  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION 
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM4' AND cqm_num1_1.criteria=2   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        ) NUM4  ON NUM4.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM5' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM5' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        ) NUM5   ON NUM5.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM6' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id  
            UNION 
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM6' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id  
	        ) NUM6   ON NUM6.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM7' AND cqm_num1_1.criteria=2   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 4
	        ) NUM7   ON NUM7.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM8' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id  
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM8' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id  
	        ) NUM8   ON NUM8.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM9' AND cqm_num1_1.criteria IN (2,4)   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria IN (3,5)   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 2
        ) NUM9   ON NUM9.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM10' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM10' AND cqm_num1_2.criteria = 2   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 2
	        ) NUM10   ON NUM10.pa_id=pat.pa_id  
	    --Common
		
		INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID INNER JOIN  CQM_Codes cqm ON PP.CODE=cqm.CODE
		WHERE cqm.version=2 AND PP.DR_ID=@doctorid AND date_performed between @fromdate AND @todate AND nqf_id='0038'
		AND cqm.isactive=1 AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype='POP1'
		AND DATEDIFF(MONTH,PAT.pa_dob,CONVERT(DATETIME,@fromdate,101)) >= 1*12 AND   DATEDIFF(MONTH,PAT.pa_dob,@fromdate)  <= 2*12 AND not (pa_dob like '1901-01-01')
		GROUP BY pa_sex
	END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) sm 
		--Common
		FROM patients pat
        INNER JOIN (
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id 
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX' 
	        AND cqm_num1_1.criteriatype='NUM1' AND cqm_num1_1.criteria=1   WHERE  cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM1' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id) NUM1 ON NUM1.pa_id=pat.pa_id 
        INNER JOIN 
	        (
	        SELECT DISTINCT(PAT.pa_id)  FROM patients pat INNER JOIN tblvaccinationrecord vacr_num1_1 on vacr_num1_1.vac_pat_id = PAT.pa_id INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM2' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by PAT.pa_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM2' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        ) NUM2  ON NUM2.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM3' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id 
	        ) NUM3  ON NUM3.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id) AS pa_id  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION 
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM4' AND cqm_num1_1.criteria=2   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM4' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        ) NUM4  ON NUM4.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM5' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 3
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM5' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 3
	        ) NUM5   ON NUM5.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM6' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id  
            UNION 
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM6' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id  
	        ) NUM6   ON NUM6.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM7' AND cqm_num1_1.criteria=2   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 4
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM7' AND cqm_num1_2.criteria=3   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 4
	        ) NUM7   ON NUM7.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM8' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id  
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM8' AND cqm_num1_2.criteria=2   WHERE cqm_num1_2.version=2 group by PAT.pa_id  
	        ) NUM8   ON NUM8.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_active_diagnosis pad_num1_3 ON pat.pa_id=pad_num1_3.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pad_num1_3.icd9 = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('ICD10CM','ICD9CM','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria=1   WHERE cqm_num1_2.version=2 group by PAT.pa_id
	        UNION
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM9' AND cqm_num1_1.criteria IN (2,4)   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM9' AND cqm_num1_2.criteria IN (3,5)   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 2
        ) NUM9   ON NUM9.pa_id=pat.pa_id
        INNER JOIN(
	        SELECT DISTINCT(vacr_num1_1.vac_pat_id) pa_id FROM tblvaccinationrecord vacr_num1_1 INNER JOIN tblVaccines vac_num1_1 on vacr_num1_1.vac_id=vac_num1_1.vac_id
	        INNER JOIN CQM_Codes cqm_num1_1 on vac_num1_1.cvx_code = cqm_num1_1.code  AND cqm_num1_1.nqf_id='0038' AND cqm_num1_1.isactive=1 AND cqm_num1_1.code_type='CVX'
	        AND cqm_num1_1.criteriatype='NUM10' AND cqm_num1_1.criteria=1   WHERE cqm_num1_1.version=2 group by vacr_num1_1.vac_pat_id having count(vac_num1_1.cvx_code) >= 2
	        UNION
	        SELECT DISTINCT(pat.pa_id)  FROM patients pat INNER JOIN patient_procedures pp_num1_2 on pp_num1_2.pa_id = pat.pa_id 
	        INNER JOIN CQM_Codes cqm_num1_2 on pp_num1_2.code = cqm_num1_2.code  AND cqm_num1_2.nqf_id='0038' AND cqm_num1_2.isactive=1 AND cqm_num1_2.code_type IN ('CPT','SNOMEDCT')
	        AND cqm_num1_2.criteriatype='NUM10' AND cqm_num1_2.criteria = 2   WHERE cqm_num1_2.version=2 group by PAT.pa_id having count(pp_num1_2.code) >= 2
	        ) NUM10   ON NUM10.pa_id=pat.pa_id  
	    --Common
		INNER JOIN patient_procedures PP ON PAT.PA_ID=PP.PA_ID INNER JOIN  CQM_Codes cqm ON PP.CODE=cqm.CODE
        INNER JOIN vwpatientpayers pyr ON pat.pa_id = pyr.pa_id
        INNER JOIN cqm_codes cqm_pyr ON pp.code=cqm_pyr.code
        WHERE cqm_pyr.version=2 AND cqm_pyr.nqf_id='0038' AND cqm.version=2 AND PP.DR_ID= @doctorid AND date_performed between @fromdate AND @todate AND cqm.nqf_id='0038'
        AND cqm.isactive=1 AND cqm.code_type IN ('CPT','SNOMEDCT')  AND cqm.criteriatype='POP1'
        AND DATEDIFF(MONTH,PAT.pa_dob,CONVERT(DATETIME,@fromdate,101)) >= 1*12 AND   DATEDIFF(MONTH,PAT.pa_dob,CONVERT(DATETIME,@fromdate,101))  <= 2*12 AND not (pa_dob like '1901-01-01') 
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
