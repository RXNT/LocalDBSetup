SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the denominator exception for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS138v2_NQF0028_POP1_NUMER] 
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
        SELECT COUNT(DISTINCT pat.pa_id) SM FROM patients PAT WITH(NOLOCK)  INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) 
			INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  
			WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
			AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 			
			AND cqm.IsExclude=0 AND dr_id= @doctorid 
			AND PP.date_performed between  @fromdate AND @todate
			GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
			SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code 
			WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' 
			AND criteriatype='POP1' AND criteria=3 
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id=  @doctorid 
			AND PP.date_performed between  @fromdate AND @todate 
			GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_1 WITH(NOLOCK) ON PP_num_1.pa_id=pat.pa_id 
          INNER JOIN cqm_codes cqm_num_1 WITH(NOLOCK) ON pp_num_1.code=cqm_num_1.code       
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 
          AND not (pa_dob like '1901-01-01')
          AND cqm_num_1.version=2 AND cqm_num_1.NQF_id='0028' 
          AND cqm_num_1.criteriatype='NUM1' AND cqm_num_1.criteria=1
         

          UNION ALL 

          SELECT COUNT(DISTINCT pat.pa_id) SM FROM patients PAT WITH(NOLOCK) INNER JOIN 
		  (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) 
				INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  
				WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
				AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 
				AND cqm.IsExclude=0 AND dr_id= @doctorid 
				AND PP.date_performed between  @fromdate AND @todate
				GROUP BY pa_id HAVING count(pa_id) >= 2 
			UNION 
			SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
				INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  
				WHERE cqm.version=2 AND cqm.NQF_id='0028' 
				AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
				AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid 
				AND PP.date_performed between  @fromdate AND @todate 
				GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id 
          INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN patient_procedures PP_num_3 WITH(NOLOCK) ON PP_num_3.pa_id=pat.pa_id 
          INNER JOIN cqm_codes cqm_num_3 WITH(NOLOCK) ON PP_num_3.code=cqm_num_3.code     
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 
          AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' 
          AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 
          AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND cqm_num_3.version=2 AND cqm_num_3.NQF_id='0028' 
          AND cqm_num_3.criteriatype='NUM1' AND cqm_num_3.criteria=3 
          AND cqm_num_3.code_type IN ('SNOMEDCT','CPT') 
         

          UNION ALL 

          SELECT COUNT(DISTINCT pat.pa_id) SM FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP  WITH(NOLOCK)
			INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  
			WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
			AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 
			AND cqm.IsExclude=0 AND dr_id= @doctorid 
			AND PP.date_performed between  @fromdate AND @todate
			GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
			SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
			INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  
			WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' 
			AND criteriatype='POP1' AND criteria=3 
			AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid 
			AND PP.date_performed between  @fromdate AND @todate 
			GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id 
          INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN prescriptions pres_num3 WITH(NOLOCK) ON pres_num3.pa_id=pat.pa_id 
          INNER JOIN doctors doc WITH(NOLOCK) ON pres_num3.dr_id = doc.dr_id  
          INNER JOIN prescription_details pd_num3 WITH(NOLOCK) 
          ON pres_num3.pres_id=pd_num3.pres_id   
          INNER JOIN REVDEL0 R1 WITH(NOLOCK) 
          on CAST(pd_num3.ddid AS VARCHAR)=R1.EVD_FDB_VOCAB_ID  
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) on R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID
          INNER JOIN CQM_Codes cqm_num3 WITH(NOLOCK) 
          ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)=cqm_num3.code        
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 
          AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' 
          AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 
          AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND  cqm_num3.version=2 AND cqm_num3.nqf_id ='0028' 
          AND cqm_num3.criteriatype='NUM1' AND cqm_num3.code_type='RXNORM' 
          AND cqm_num3.criteria=3 
          AND pres_num3.pres_void = 0 AND pd_num3.history_enabled = 1  
          AND pres_num3.pres_approved_date IS NULL 
          and pres_num3.pres_entry_date between @fromdate AND @todate 
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		SELECT pa_race_type,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id=  @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_1 WITH(NOLOCK) ON PP_num_1.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_1 WITH(NOLOCK) ON pp_num_1.code=cqm_num_1.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_1.version=2 AND cqm_num_1.NQF_id='0028' AND cqm_num_1.criteriatype='NUM1' AND cqm_num_1.criteria=1
           GROUP BY pa_race_type 

          UNION ALL 

          SELECT pa_race_type,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN patient_procedures PP_num_3 WITH(NOLOCK) ON PP_num_3.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_3 WITH(NOLOCK) ON PP_num_3.code=cqm_num_3.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND cqm_num_3.version=2 AND cqm_num_3.NQF_id='0028' AND cqm_num_3.criteriatype='NUM1' AND cqm_num_3.criteria=3 AND cqm_num_3.code_type IN ('SNOMEDCT','CPT') 
           GROUP BY pa_race_type 

          UNION ALL 

          SELECT pa_race_type,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN prescriptions pres_num3 WITH(NOLOCK) ON pres_num3.pa_id=pat.pa_id INNER JOIN doctors doc WITH(NOLOCK) ON pres_num3.dr_id = doc.dr_id  
          INNER JOIN prescription_details pd_num3 WITH(NOLOCK) ON pres_num3.pres_id=pd_num3.pres_id   
          INNER JOIN REVDEL0 R1 WITH(NOLOCK) on CAST(pd_num3.ddid AS VARCHAR)=R1.EVD_FDB_VOCAB_ID  
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) on R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID
          INNER JOIN CQM_Codes cqm_num3 WITH(NOLOCK) ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)=cqm_num3.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND  cqm_num3.version=2 AND cqm_num3.nqf_id ='0028' AND cqm_num3.criteriatype='NUM1' AND cqm_num3.code_type='RXNORM' AND cqm_num3.criteria=3 
          AND pres_num3.pres_void = 0 AND pd_num3.history_enabled = 1  AND pres_num3.pres_approved_date IS NULL 
          and pres_num3.pres_entry_date between @fromdate AND @todate 
           GROUP BY pa_race_type 
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id=  @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_1 WITH(NOLOCK) ON PP_num_1.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_1 WITH(NOLOCK) ON pp_num_1.code=cqm_num_1.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_1.version=2 AND cqm_num_1.NQF_id='0028' AND cqm_num_1.criteriatype='NUM1' AND cqm_num_1.criteria=1
           GROUP BY pa_ethn_type 

          UNION ALL 

          SELECT pa_ethn_type,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN patient_procedures PP_num_3 WITH(NOLOCK) ON PP_num_3.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_3 WITH(NOLOCK) ON PP_num_3.code=cqm_num_3.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND cqm_num_3.version=2 AND cqm_num_3.NQF_id='0028' AND cqm_num_3.criteriatype='NUM1' AND cqm_num_3.criteria=3 AND cqm_num_3.code_type IN ('SNOMEDCT','CPT') 
           GROUP BY pa_ethn_type 

          UNION ALL 

          SELECT pa_ethn_type,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN prescriptions pres_num3 WITH(NOLOCK) ON pres_num3.pa_id=pat.pa_id INNER JOIN doctors doc WITH(NOLOCK) ON pres_num3.dr_id = doc.dr_id  
          INNER JOIN prescription_details pd_num3 WITH(NOLOCK) ON pres_num3.pres_id=pd_num3.pres_id   
          INNER JOIN REVDEL0 R1 WITH(NOLOCK) on CAST(pd_num3.ddid AS VARCHAR)=R1.EVD_FDB_VOCAB_ID  
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) on R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID
          INNER JOIN CQM_Codes cqm_num3 WITH(NOLOCK) ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)=cqm_num3.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND  cqm_num3.version=2 AND cqm_num3.nqf_id ='0028' AND cqm_num3.criteriatype='NUM1' AND cqm_num3.code_type='RXNORM' AND cqm_num3.criteria=3 
          AND pres_num3.pres_void = 0 AND pd_num3.history_enabled = 1  AND pres_num3.pres_approved_date IS NULL 
          and pres_num3.pres_entry_date between @fromdate AND @todate 
           GROUP BY pa_ethn_type 
               
	END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm  WITH(NOLOCK)ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id=  @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_1 WITH(NOLOCK) ON PP_num_1.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_1 WITH(NOLOCK) ON pp_num_1.code=cqm_num_1.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_1.version=2 AND cqm_num_1.NQF_id='0028' AND cqm_num_1.criteriatype='NUM1' AND cqm_num_1.criteria=1
           GROUP BY pa_sex 

          UNION ALL 

          SELECT pa_sex,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN patient_procedures PP_num_3 WITH(NOLOCK) ON PP_num_3.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_3 WITH(NOLOCK) ON PP_num_3.code=cqm_num_3.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND cqm_num_3.version=2 AND cqm_num_3.NQF_id='0028' AND cqm_num_3.criteriatype='NUM1' AND cqm_num_3.criteria=3 AND cqm_num_3.code_type IN ('SNOMEDCT','CPT') 
           GROUP BY pa_sex 

          UNION ALL 

          SELECT pa_sex,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN prescriptions pres_num3 WITH(NOLOCK) ON pres_num3.pa_id=pat.pa_id INNER JOIN doctors doc WITH(NOLOCK) ON pres_num3.dr_id = doc.dr_id  
          INNER JOIN prescription_details pd_num3 WITH(NOLOCK) ON pres_num3.pres_id=pd_num3.pres_id   
          INNER JOIN REVDEL0 R1 WITH(NOLOCK) on CAST(pd_num3.ddid AS VARCHAR)=R1.EVD_FDB_VOCAB_ID  
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) on R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID
          INNER JOIN CQM_Codes cqm_num3 WITH(NOLOCK) ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)=cqm_num3.code 
         
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND  cqm_num3.version=2 AND cqm_num3.nqf_id ='0028' AND cqm_num3.criteriatype='NUM1' AND cqm_num3.code_type='RXNORM' AND cqm_num3.criteria=3 
          AND pres_num3.pres_void = 0 AND pd_num3.history_enabled = 1  AND pres_num3.pres_approved_date IS NULL 
          and pres_num3.pres_entry_date between @fromdate AND @todate 
           GROUP BY pa_sex 
	END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		  SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id=  @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_1 WITH(NOLOCK) ON PP_num_1.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_1 WITH(NOLOCK) ON pp_num_1.code=cqm_num_1.code 
           INNER JOIN vwpatientpayers pyr WITH(NOLOCK) ON pat.pa_id = pyr.pa_id  INNER JOIN cqm_codes cqm_pyr WITH(NOLOCK) ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_1.version=2 AND cqm_num_1.NQF_id='0028' AND cqm_num_1.criteriatype='NUM1' AND cqm_num_1.criteria=1
           AND cqm_pyr.version=2 AND cqm_pyr.nqf_id='0028' GROUP BY medicare_type_code 

          UNION ALL 

          SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN patient_procedures PP_num_3 WITH(NOLOCK) ON PP_num_3.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_3 WITH(NOLOCK) ON PP_num_3.code=cqm_num_3.code 
           INNER JOIN vwpatientpayers pyr WITH(NOLOCK) ON pat.pa_id = pyr.pa_id  INNER JOIN cqm_codes cqm_pyr WITH(NOLOCK) ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND cqm_num_3.version=2 AND cqm_num_3.NQF_id='0028' AND cqm_num_3.criteriatype='NUM1' AND cqm_num_3.criteria=3 AND cqm_num_3.code_type IN ('SNOMEDCT','CPT') 
           AND cqm_pyr.version=2 AND cqm_pyr.nqf_id='0028' GROUP BY medicare_type_code 

          UNION ALL 

          SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) sm FROM patients PAT WITH(NOLOCK) INNER JOIN 
          (SELECT pa_id FROM patient_procedures PP WITH(NOLOCK) INNER JOIN cqm_codes cqm WITH(NOLOCK) ON pp.code=cqm.code  WHERE cqm.version=2 and cqm.nqf_id='0028' AND cqm.code_type='CPT'
          AND criteriatype='POP1' AND criteria=2  AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate
          GROUP BY pa_id HAVING count(pa_id) >= 2 
          UNION 
          SELECT pa_id FROM patient_procedures PP WITH(NOLOCK)
          INNER JOIN CQM_Codes cqm WITH(NOLOCK) ON PP.code=cqm.code  WHERE cqm.version=2 AND cqm.NQF_id='0028' AND cqm.code_type='CPT' AND criteriatype='POP1' AND criteria=3 
          AND cqm.IsActive=1 AND cqm.IsExclude=0 AND dr_id= @doctorid AND PP.date_performed between  @fromdate AND @todate GROUP BY pa_id HAVING COUNT(pa_id) >= 1 
          )PPC ON PAT.pa_id=PPC.pa_id
          INNER JOIN patient_procedures PP_num_2 WITH(NOLOCK) ON PP_num_2.pa_id=pat.pa_id INNER JOIN cqm_codes cqm_num_2 WITH(NOLOCK) ON pp_num_2.code=cqm_num_2.code 
          INNER JOIN prescriptions pres_num3 WITH(NOLOCK) ON pres_num3.pa_id=pat.pa_id INNER JOIN doctors doc WITH(NOLOCK) ON pres_num3.dr_id = doc.dr_id  
          INNER JOIN prescription_details pd_num3 WITH(NOLOCK) ON pres_num3.pres_id=pd_num3.pres_id   
          INNER JOIN REVDEL0 R1 WITH(NOLOCK) on CAST(pd_num3.ddid AS VARCHAR)=R1.EVD_FDB_VOCAB_ID  
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) on R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID
          INNER JOIN CQM_Codes cqm_num3 WITH(NOLOCK) ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)=cqm_num3.code 
           INNER JOIN vwpatientpayers pyr WITH(NOLOCK) ON pat.pa_id = pyr.pa_id  INNER JOIN cqm_codes cqm_pyr WITH(NOLOCK) ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
          WHERE datediff(month,PAT.pa_dob,CONVERT(datetime,@fromdate,101)) >= 18*12 AND not (pa_dob like '1901-01-01')
          AND cqm_num_2.version=2 AND cqm_num_2.NQF_id='0028' AND cqm_num_2.criteriatype='NUM1' AND cqm_num_2.criteria=2 AND cqm_num_2.code_type IN ('SNOMEDCT','CPT') 
          AND  cqm_num3.version=2 AND cqm_num3.nqf_id ='0028' AND cqm_num3.criteriatype='NUM1' AND cqm_num3.code_type='RXNORM' AND cqm_num3.criteria=3 
          AND pres_num3.pres_void = 0 AND pd_num3.history_enabled = 1  AND pres_num3.pres_approved_date IS NULL 
          and pres_num3.pres_entry_date between @fromdate AND @todate 
           AND cqm_pyr.version=2 AND cqm_pyr.nqf_id='0028' GROUP BY medicare_type_code 
	END
	SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
