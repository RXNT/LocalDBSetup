SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS69v2_NQF0421_POP2_NUMER] 
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
	SELECT  count(distinct pat.pa_id) SM 
		FROM patients pat with(nolock) 
		INNER JOIN 
		(
			(SELECT pv.pa_id 
				FROM 
				patients PAT WITH(NOLOCK) 
				INNER JOIN patient_vitals pv with(nolock) on PAT.PA_ID = PV.PA_ID
				INNER JOIN patient_procedures pp with(nolock) ON pv.pa_id=pp.pa_id 
				INNER JOIN CQM_Codes cqm with(nolock) ON PP.code=cqm.code
				WHERE 
				DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 
					AND NOT (pa_dob like '1901-01-01') 
				AND pp.dr_id = @doctorid 
				AND PV.record_date 
				BETWEEN DATEADD(MONTH,-6,pp.date_performed) 
				AND pp.date_performed 
				AND ROUND(pa_bmi,1) >= 23 
				AND ROUND(pa_bmi,1) < 30 
				AND cqm.version=2 AND cqm.NQF_id='0421' 
				AND cqm.code_type IN ('CPT','SNOMEDCT') 
				AND criteriatype='Common1' 
				AND criteria=2
				AND cqm.IsActive=1 AND cqm.IsExclude=0 
				AND PP.date_performed BETWEEN @fromdate AND @todate 
			)
				
				UNION
				
			(
				SELECT PV.pa_id 
				FROM patients PAT WITH(NOLOCK)
				INNER JOIN patient_vitals PV with(nolock) on PAT.pa_id = PV.pa_id
				INNER JOIN patient_procedures pp with(nolock) ON PV.pa_id=pp.pa_id 
				INNER JOIN patient_active_diagnosis PAD with(nolock) ON PV.pa_id=PAD.pa_id 
				INNER JOIN CQM_Codes cqm with(nolock) ON PP.code=cqm.code
				where 
				pp.dr_id =  @doctorid 
				AND DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12
					AND NOT (PAT.pa_dob like '1901-01-01') 
				AND PV.record_date 
				BETWEEN DATEADD(MONTH,-6,pp.date_performed) 
				AND pp.date_performed 
				AND cqm.version=2 AND cqm.NQF_id='0421' 
				AND cqm.code_type IN ('CPT','SNOMEDCT') 
				AND criteriatype='Common1' 
				AND criteria=2
				AND cqm.IsActive=1 AND cqm.IsExclude=0 
				AND PP.date_performed BETWEEN @fromdate AND @todate 
				AND NOT(ROUND(pa_bmi,1) >= 23 AND ROUND(pa_bmi,1) < 30)
				AND (PAD.onset IS NULL OR PAD.onset < @todate)
				AND (
				PAD.icd9 in 
				(SELECT CODE 
							FROM CQM_Codes cqm with(nolock) 
							where  cqm.version=2 AND cqm.NQF_id='0421' 
							AND cqm.code_type IN ('ICD9CM','ICD10CM') 
							AND criteriatype='Common1' AND criteria=5 AND IsActive=1
				  )  
				  OR 
				PAD.icd10 IN 
					(	SELECT CODE 
							FROM CQM_Codes cqm with(nolock) 
							where  cqm.version=2 AND cqm.NQF_id='0421' 
							AND cqm.code_type IN ('ICD9CM','ICD10CM') 
							AND criteriatype='Common1' AND criteria=5 AND IsActive=1
					)
				)
			)
		)RS on PAT.pa_id = RS.pa_id        
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		SELECT pa_race_type ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT WITH(NOLOCK) INNER JOIN 
		(
			(SELECT pv.pa_id 
			FROM patient_vitals pv WITH(NOLOCK)
			INNER JOIN patient_procedures PP WITH(NOLOCK) ON pv.pa_id=PP.pa_id 
			WHERE pp.dr_id = @doctorid AND pv.record_date BETWEEN DATEADD(MONTH,-6,PP.date_performed) AND
            PP.date_performed AND ROUND(pa_bmi,1) >= 18.5 AND ROUND(pa_bmi,1) < 25 AND pv.pa_id in (
            -- Sub query start here
			SELECT DISTINCT PAT.pa_id 
			FROM patients PAT WITH(NOLOCK) INNER JOIN 
			(	SELECT pa_id 
				FROM patient_procedures PP WITH(NOLOCK)
				INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code 
				WHERE  cqm.version=2 AND  cqm.NQF_id='0421' AND cqm.code_type='CPT' AND criteriatype='Common1' AND criteria=2 
				AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
				GROUP BY pa_id 
				HAVING COUNT(pa_id) >= 1
			)PPC ON PAT.pa_id=PPC.pa_id 
			WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')
            -- Sub query end here
            ) GROUP BY pv.pa_id
         ) 
         UNION 
         (SELECT pv.pa_id FROM patient_vitals pv WITH(NOLOCK) 
         INNER JOIN patient_procedures PP WITH(NOLOCK) ON pv.pa_id=PP.pa_id
         INNER JOIN patient_active_diagnosis PAD WITH(NOLOCK) ON pv.pa_id=PAD.pa_id WHERE pp.dr_id = @doctorid
         AND pv.pa_id in (
                    -- Sub query start here
					 SELECT DISTINCT PAT.pa_id 
					 FROM patients PAT WITH(NOLOCK) INNER JOIN 
					 (	SELECT pa_id 
						FROM patient_procedures PP WITH(NOLOCK)
						INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code 
						WHERE  cqm.version=2 AND  cqm.NQF_id='0421' AND cqm.code_type='CPT' AND criteriatype='Common1' AND criteria=2 
						AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
						GROUP BY pa_id 
						HAVING COUNT(pa_id) >= 1
					)PPC ON PAT.pa_id=PPC.pa_id 
					WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')
                        -- Sub query end here
                    ) AND
        pv.record_date BETWEEN DATEADD(MONTH,-6,PP.date_performed) AND PP.date_performed AND
        NOT(ROUND(pa_bmi,1) >= 18.5 AND ROUND(pa_bmi,1) < 25) AND PAD.icd9 in 
        (SELECT CODE FROM CQM_Codes cqm WITH(NOLOCK) WHERE  cqm.version=2 AND cqm.NQF_id='0421'
        AND cqm.code_type IN ('ICD9CM','ICD10CM') AND criteriatype='Common1' AND criteria=5 AND IsActive=1) group by pv.pa_id)
        )PP ON PAT.pa_id=PP.pa_id
        GROUP BY pa_race_type 
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT WITH(NOLOCK) INNER JOIN 
        (	SELECT pa_id 
			FROM patient_procedures PP WITH(NOLOCK)
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code 
            WHERE  cqm.version=2 AND  cqm.NQF_id='0421' AND cqm.code_type='CPT' AND criteriatype='Common1' AND criteria=2 
            AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
            GROUP BY pa_id HAVING COUNT(pa_id) >= 1
        )PPC ON PAT.pa_id=PPC.pa_id 
        WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')  
        GROUP BY pa_ethn_type
    END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT WITH(NOLOCK) INNER JOIN 
		(
			(SELECT pv.pa_id 
			FROM patient_vitals pv WITH(NOLOCK) 
			INNER JOIN patient_procedures PP WITH(NOLOCK) ON pv.pa_id=PP.pa_id 
			WHERE pp.dr_id = @doctorid AND pv.record_date BETWEEN DATEADD(MONTH,-6,PP.date_performed) AND
            PP.date_performed AND ROUND(pa_bmi,1) >= 18.5 AND ROUND(pa_bmi,1) < 25 AND pv.pa_id in (
            -- Sub query start here
			SELECT DISTINCT PAT.pa_id 
			FROM patients PAT WITH(NOLOCK) INNER JOIN 
			(	SELECT pa_id 
				FROM patient_procedures PP WITH(NOLOCK) 
				INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code 
				WHERE  cqm.version=2 AND  cqm.NQF_id='0421' AND cqm.code_type='CPT' AND criteriatype='Common1' AND criteria=2 
				AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
				GROUP BY pa_id 
				HAVING COUNT(pa_id) >= 1
			)PPC ON PAT.pa_id=PPC.pa_id 
			WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')
            -- Sub query end here
            ) GROUP BY pv.pa_id
         ) UNION 
         (SELECT pv.pa_id FROM patient_vitals pv WITH(NOLOCK) 
         INNER JOIN patient_procedures PP WITH(NOLOCK) ON pv.pa_id=PP.pa_id
         INNER JOIN patient_active_diagnosis PAD WITH(NOLOCK) ON pv.pa_id=PAD.pa_id WHERE pp.dr_id = @doctorid
         AND pv.pa_id in (
                    -- Sub query start here
					 SELECT DISTINCT PAT.pa_id 
					 FROM patients PAT WITH(NOLOCK) INNER JOIN 
					 (	SELECT pa_id 
						FROM patient_procedures PP WITH(NOLOCK)
						INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code 
						WHERE  cqm.version=2 AND  cqm.NQF_id='0421' AND cqm.code_type='CPT' AND criteriatype='Common1' AND criteria=2 
						AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
						GROUP BY pa_id 
						HAVING COUNT(pa_id) >= 1
					)PPC ON PAT.pa_id=PPC.pa_id 
					WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')
                        -- Sub query end here
                    ) AND
        pv.record_date BETWEEN DATEADD(MONTH,-6,PP.date_performed) AND PP.date_performed AND
        NOT(ROUND(pa_bmi,1) >= 18.5 AND ROUND(pa_bmi,1) < 25) AND PAD.icd9 in 
        (SELECT CODE FROM CQM_Codes cqm WITH(NOLOCK) WHERE  cqm.version=2 AND cqm.NQF_id='0421'
        AND cqm.code_type IN ('ICD9CM','ICD10CM') AND criteriatype='Common1' AND criteria=5 AND IsActive=1) group by pv.pa_id
        ))PP ON PAT.pa_id=PP.pa_id
        GROUP BY pa_sex
    END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT WITH(NOLOCK) INNER JOIN 
		(
			(SELECT pv.pa_id 
			FROM patient_vitals pv WITH(NOLOCK) 
			INNER JOIN patient_procedures PP WITH(NOLOCK) ON pv.pa_id=PP.pa_id 
			WHERE pp.dr_id = @doctorid AND pv.record_date BETWEEN DATEADD(MONTH,-6,PP.date_performed) AND
            PP.date_performed AND ROUND(pa_bmi,1) >= 18.5 AND ROUND(pa_bmi,1) < 25 AND pv.pa_id in (
            -- Sub query start here
			SELECT DISTINCT PAT.pa_id 
			FROM patients PAT WITH(NOLOCK) INNER JOIN 
			(	SELECT pa_id 
				FROM patient_procedures PP WITH(NOLOCK)
				INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code 
				WHERE  cqm.version=2 AND  cqm.NQF_id='0421' AND cqm.code_type='CPT' AND criteriatype='Common1' AND criteria=2 
				AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
				GROUP BY pa_id 
				HAVING COUNT(pa_id) >= 1
			)PPC ON PAT.pa_id=PPC.pa_id 
			WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')
            -- Sub query end here
            ) GROUP BY pv.pa_id
         ) UNION 
         (SELECT pv.pa_id FROM patient_vitals pv WITH(NOLOCK)
         INNER JOIN patient_procedures PP WITH(NOLOCK) ON pv.pa_id=PP.pa_id
         INNER JOIN patient_active_diagnosis PAD WITH(NOLOCK) ON pv.pa_id=PAD.pa_id WHERE pp.dr_id = @doctorid
         AND pv.pa_id in (
                    -- Sub query start here
					 SELECT DISTINCT PAT.pa_id 
					 FROM patients PAT WITH(NOLOCK) INNER JOIN 
					 (	SELECT pa_id 
						FROM patient_procedures PP WITH(NOLOCK) 
						INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code 
						WHERE  cqm.version=2 AND  cqm.NQF_id='0421' AND cqm.code_type='CPT' AND criteriatype='Common1' AND criteria=2 
						AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
						GROUP BY pa_id 
						HAVING COUNT(pa_id) >= 1
					)PPC ON PAT.pa_id=PPC.pa_id 
					WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')
                        -- Sub query end here
                    ) AND
        pv.record_date BETWEEN DATEADD(MONTH,-6,PP.date_performed) AND PP.date_performed AND
        NOT(ROUND(pa_bmi,1) >= 18.5 AND ROUND(pa_bmi,1) < 25) AND PAD.icd9 in 
        (SELECT CODE FROM CQM_Codes cqm WITH(NOLOCK) WHERE  cqm.version=2 AND cqm.NQF_id='0421'
        AND cqm.code_type IN ('ICD9CM','ICD10CM') AND criteriatype='Common1' AND criteria=5 AND IsActive=1) group by pv.pa_id
        ))PP ON PAT.pa_id=PP.pa_id
        INNER JOIN vwpatientpayers pyr WITH(NOLOCK) ON pat.pa_id = pyr.pa_id 
        INNER JOIN cqm_codes cqm_pyr WITH(NOLOCK) ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591' 
        WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')  AND cqm_pyr.version=2 AND cqm_pyr.nqf_id='0421' 
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
