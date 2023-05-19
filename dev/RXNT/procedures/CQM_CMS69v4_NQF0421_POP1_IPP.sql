SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/08/2016
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS69v4_NQF0421_POP1_IPP] 
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

    IF @type = 1 --Patients
	BEGIN
		SELECT DISTINCT pat.pa_id 
		FROM patients PAT with(nolock) 
		INNER JOIN 
		(	SELECT PP.pa_id 
			FROM patient_procedures PP with(nolock) 
			INNER JOIN CQM_CodesV4 cqm with(nolock) ON PP.code=cqm.code
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND criteriatype='Common1' AND criteria=2 
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN 
			@fromdate AND @todate GROUP BY PP.pa_id HAVING COUNT(PP.pa_id) >= 1
		)PPC ON PAT.pa_id=PPC.pa_id 
		WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01')  
		UNION 
		SELECT distinct PAT.pa_id FROM 
		patients PAT with(nolock) 
		INNER JOIN 
		(	SELECT pa_id FROM patient_procedures PP with(nolock) 
			INNER JOIN CQM_CodesV4 cqm with(nolock) ON PP.code=cqm.code 
			WHERE  cqm.version=2 AND  cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND criteriatype='Common1' AND criteria=2 
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN 
			@fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1
		)PPC ON PAT.pa_id=PPC.pa_id 
		WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 18*12 AND 64*12 AND NOT (pa_dob like '1901-01-01')
	END
    ELSE IF @type = 2 --All
	BEGIN
		SELECT COUNT(distinct PAT.pa_id) AS SM 
		FROM patients PAT with(nolock) INNER JOIN
        (	SELECT PP.pa_id 
			FROM patient_procedures PP with(nolock) 
			INNER JOIN CQM_CodesV4 cqm with(nolock) ON PP.code=cqm.code
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND criteriatype='Common1' AND criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			GROUP BY PP.pa_id 
			HAVING count(PP.pa_id) >= 1
		)PPC ON PAT.pa_id=PPC.pa_id
        WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01')
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		SELECT pa_race_type ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT with(nolock) 
		INNER JOIN
        (	SELECT PP.pa_id FROM patient_procedures PP with(nolock) 
			INNER JOIN CQM_CodesV4 cqm with(nolock) ON PP.code=cqm.code
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND criteriatype='Common1' AND criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			GROUP BY PP.pa_id 
			HAVING count(PP.pa_id) >= 1
		)PPC ON PAT.pa_id=PPC.pa_id
        WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01')  
        GROUP BY pa_race_type
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT with(nolock) 
		INNER JOIN
        (
			SELECT PP.pa_id 
			FROM patient_procedures PP with(nolock) 
			INNER JOIN CQM_CodesV4 cqm with(nolock) ON PP.code=cqm.code
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND criteriatype='Common1' AND criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN
			@fromdate AND @todate 
			GROUP BY PP.pa_id 
			HAVING count(PP.pa_id) >= 1
		)PPC ON PAT.pa_id=PPC.pa_id
		WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01') 
		GROUP BY pa_ethn_type
    END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		 SELECT pa_sex ,COUNT(DISTINCT pat.pa_id) SM  
		 FROM patients PAT with(nolock) 
		 INNER JOIN
        (	SELECT PP.pa_id 
			FROM patient_procedures PP with(nolock) 
			INNER JOIN CQM_CodesV4 cqm with(nolock) ON PP.code=cqm.code
            WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND criteriatype='Common1' AND criteria=2
            AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
            GROUP BY PP.pa_id 
            HAVING count(PP.pa_id) >= 1
        )PPC ON PAT.pa_id=PPC.pa_id
            WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01') 
            GROUP BY pa_sex
    END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients PAT with(nolock) 
		INNER JOIN
        (	SELECT PP.pa_id 
			FROM patient_procedures PP with(nolock) 
			INNER JOIN CQM_CodesV4 cqm with(nolock) ON PP.code=cqm.code
			WHERE cqm.version=2 AND cqm.NQF_id='0421' AND cqm.code_type IN ('CPT','SNOMEDCT') AND criteriatype='Common1' AND criteria=2
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed BETWEEN @fromdate AND @todate 
			GROUP BY PP.pa_id 
			HAVING count(PP.pa_id) >= 1
		)PPC ON PAT.pa_id=PPC.pa_id
        INNER JOIN vwpatientpayers pyr with(nolock) ON pat.pa_id = pyr.pa_id
        INNER JOIN CQM_CodesV4 cqm_pyr with(nolock) ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
        WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) >= 65*12 AND NOT (pa_dob like '1901-01-01') AND cqm_pyr.version=2 AND cqm_pyr.nqf_id='0421' 
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
