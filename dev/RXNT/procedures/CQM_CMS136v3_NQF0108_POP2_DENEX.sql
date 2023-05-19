SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the denominator exclusion for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS136v3_NQF0108_POP2_DENEX] 
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
	select COUNT(distinct pat.pa_id) SM from patients PAT inner join (
        SELECT pres_ipp.pa_id FROM  
        prescriptions pres_ipp  
        INNER JOIN prescription_details pd_ipp ON pres_ipp.pres_id=pd_ipp.pres_id 
        INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_ipp.ddid AS VARCHAR)=r1.evd_fdb_vocab_id   
        INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id    
        INNER JOIN cqm_codes cqm_pam_ipp 
        ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp.code  
        INNER JOIN 	patient_procedures PP_ipp ON PP_ipp.pa_id=pres_ipp.pa_id  
        AND DATEDIFF(day,pres_ipp.pres_approved_date,PP_ipp.date_performed) 
        BETWEEN 0 AND 30  
        INNER JOIN cqm_codes cqm_pp_ipp ON cqm_pp_ipp.code = PP_ipp.code  
        INNER JOIN patient_active_meds pam_ipp1 ON pres_ipp.pa_id=pam_ipp1.pa_id 
        INNER JOIN revdel0 r1_ipp1 WITH(NOLOCK) 
        ON CAST(pam_ipp1.drug_id AS VARCHAR)=r1_ipp1.evd_fdb_vocab_id   
        INNER JOIN REVDVT0 R2_ipp1 WITH(NOLOCK) 
        ON  r1_ipp1.evd_ext_vocab_type_id=R2_ipp1.evd_vocab_type_id    
        INNER JOIN cqm_codes cqm_pam_ipp1 
        ON CAST(r1_ipp1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp1.code
        INNER JOIN patient_active_diagnosis pad_excl ON  PP_ipp.pa_id=pad_excl.pa_id 
         INNER JOIN cqm_codes cqm_pad_excl ON cqm_pad_excl.code = pad_excl.icd9  
         WHERE PP_ipp.dr_id= @doctorid AND PP_ipp.date_performed 
         between @fromdate AND @todate 
         AND cqm_pam_ipp.version=2 AND cqm_pam_ipp.nqf_id='0108' 
         AND cqm_pam_ipp.isactive=1 AND cqm_pam_ipp.code_type ='RXNORM'  
         AND cqm_pam_ipp.criteriatype='COMMON1' AND cqm_pam_ipp.isexclude=0 
         AND cqm_pam_ipp.criteria=1
         AND cqm_pp_ipp.version=2 AND cqm_pp_ipp.nqf_id='0108' 
         AND cqm_pp_ipp.isactive=1 AND cqm_pp_ipp.code_type IN ('CPT','SNOMEDCT')  
         AND cqm_pp_ipp.criteriatype='COMMON1' AND cqm_pp_ipp.isexclude=0 
         AND cqm_pp_ipp.criteria=3  
         AND cqm_pam_ipp1.version=2 AND cqm_pam_ipp1.nqf_id='0108' 
         AND cqm_pam_ipp1.isactive=1 AND cqm_pam_ipp1.code_type  ='RXNORM' 
         AND cqm_pam_ipp1.criteriatype='COMMON1' AND cqm_pam_ipp1.isexclude=0 
         AND cqm_pam_ipp1.criteria=1
         AND cqm_pad_excl.version=2 AND cqm_pad_excl.nqf_id='0108' 
         AND cqm_pad_excl.isactive=1 
         AND cqm_pad_excl.code_type IN ('ICD9CM','SNOMEDCT','ICD10CM')  
         AND cqm_pad_excl.criteriatype='COMMON1' AND cqm_pad_excl.isexclude=1 
         AND cqm_pad_excl.criteria = 4  
         AND pres_ipp.pres_void = 0 AND pd_ipp.history_enabled = 1 
         
         UNION
         
         SELECT pres_ipp.pa_id FROM  
        prescriptions pres_ipp  
        INNER JOIN prescription_details pd_ipp ON pres_ipp.pres_id=pd_ipp.pres_id 
        INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_ipp.ddid AS VARCHAR)=r1.evd_fdb_vocab_id   
        INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id    
        INNER JOIN cqm_codes cqm_pam_ipp 
        ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp.code  
        INNER JOIN 	patient_procedures PP_ipp ON PP_ipp.pa_id=pres_ipp.pa_id  
        AND DATEDIFF(day,pres_ipp.pres_approved_date,PP_ipp.date_performed) 
        BETWEEN 0 AND 30  
        INNER JOIN cqm_codes cqm_pp_ipp ON cqm_pp_ipp.code = PP_ipp.code  
        INNER JOIN patient_active_meds pam_ipp1 ON pres_ipp.pa_id=pam_ipp1.pa_id 
        INNER JOIN revdel0 r1_ipp1 WITH(NOLOCK) 
        ON CAST(pam_ipp1.drug_id AS VARCHAR)=r1_ipp1.evd_fdb_vocab_id   
        INNER JOIN REVDVT0 R2_ipp1 WITH(NOLOCK) 
        ON  r1_ipp1.evd_ext_vocab_type_id=R2_ipp1.evd_vocab_type_id    
        INNER JOIN cqm_codes cqm_pam_ipp1 
        ON CAST(r1_ipp1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp1.code
        INNER JOIN patient_active_meds pam_excl ON pres_ipp.pa_id=pam_excl.pa_id
         INNER JOIN revdel0 R1_excl WITH(NOLOCK) 
         ON CAST(pam_excl.drug_id AS VARCHAR)=R1_excl.evd_fdb_vocab_id  
         INNER JOIN REVDVT0 R2_excl WITH(NOLOCK) 
         ON  r1_excl.evd_ext_vocab_type_id=R2_excl.evd_vocab_type_id   
         INNER JOIN cqm_codes cqm_pres_excl 
         ON cqm_pres_excl.code =CAST(R1_excl.EVD_EXT_VOCAB_ID AS VARCHAR)
         WHERE PP_ipp.dr_id= @doctorid AND PP_ipp.date_performed 
         between @fromdate AND @todate 
         AND cqm_pam_ipp.version=2 AND cqm_pam_ipp.nqf_id='0108' 
         AND cqm_pam_ipp.isactive=1 AND cqm_pam_ipp.code_type ='RXNORM'  
         AND cqm_pam_ipp.criteriatype='COMMON1' AND cqm_pam_ipp.isexclude=0 
         AND cqm_pam_ipp.criteria=1
         AND cqm_pp_ipp.version=2 AND cqm_pp_ipp.nqf_id='0108' 
         AND cqm_pp_ipp.isactive=1 AND cqm_pp_ipp.code_type IN ('CPT','SNOMEDCT')  
         AND cqm_pp_ipp.criteriatype='COMMON1' AND cqm_pp_ipp.isexclude=0 
         AND cqm_pp_ipp.criteria=3  
         AND cqm_pam_ipp1.version=2 AND cqm_pam_ipp1.nqf_id='0108' 
         AND cqm_pam_ipp1.isactive=1 AND cqm_pam_ipp1.code_type  ='RXNORM' 
         AND cqm_pam_ipp1.criteriatype='COMMON1' AND cqm_pam_ipp1.isexclude=0 
         AND cqm_pam_ipp1.criteria=1  
         AND cqm_pres_excl.version=2 AND cqm_pres_excl.nqf_id='0108' 
         AND cqm_pres_excl.isactive=1 AND cqm_pres_excl.code_type ='RXNORM'  
         AND cqm_pres_excl.criteriatype='COMMON1' AND cqm_pres_excl.isexclude=0 
         AND cqm_pres_excl.criteria = 1
         AND DATEDIFF(day,pam_excl.date_start,pres_ipp.pres_approved_date) BETWEEN  1 AND 120
         AND pres_ipp.pres_void = 0 AND pd_ipp.history_enabled = 1    
         )PPC on PAT.pa_id=PPC.pa_id 
         WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 6*12 and 12*12
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		  select  pa_race_type,COUNT(DISTINCT pat.pa_id) sm  from patients PAT inner join (
          SELECT pres_ipp.pa_id FROM  
          prescriptions pres_ipp  
          INNER JOIN prescription_details pd_ipp ON pres_ipp.pres_id=pd_ipp.pres_id 
          INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_ipp.ddid AS VARCHAR)=r1.evd_fdb_vocab_id   
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id    
          INNER JOIN cqm_codes cqm_pam_ipp ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp.code  
          INNER JOIN 	patient_procedures PP_ipp ON PP_ipp.pa_id=pres_ipp.pa_id  AND DATEDIFF(day,pres_ipp.pres_approved_date,PP_ipp.date_performed) BETWEEN 0 AND 30  
          INNER JOIN cqm_codes cqm_pp_ipp ON cqm_pp_ipp.code = PP_ipp.code  

          INNER JOIN patient_active_meds pam_ipp1 ON pres_ipp.pa_id=pam_ipp1.pa_id 
          INNER JOIN revdel0 r1_ipp1 WITH(NOLOCK) ON CAST(pam_ipp1.drug_id AS VARCHAR)=r1_ipp1.evd_fdb_vocab_id   
          INNER JOIN REVDVT0 R2_ipp1 WITH(NOLOCK) ON  r1_ipp1.evd_ext_vocab_type_id=R2_ipp1.evd_vocab_type_id    
          INNER JOIN cqm_codes cqm_pam_ipp1 ON CAST(r1_ipp1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp1.code  


           WHERE PP_ipp.dr_id= @doctorid AND PP_ipp.date_performed between @fromdate AND @todate 
           AND cqm_pam_ipp.version=2 AND cqm_pam_ipp.nqf_id='0108' AND cqm_pam_ipp.isactive=1 AND cqm_pam_ipp.code_type ='RXNORM'  AND cqm_pam_ipp.criteriatype='COMMON1' AND cqm_pam_ipp.isexclude=0 AND cqm_pam_ipp.criteria=1
           AND cqm_pp_ipp.version=2 AND cqm_pp_ipp.nqf_id='0108' AND cqm_pp_ipp.isactive=1 AND cqm_pp_ipp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp_ipp.criteriatype='COMMON1' AND cqm_pp_ipp.isexclude=0 AND cqm_pp_ipp.criteria=3  
           AND cqm_pam_ipp1.version=2 AND cqm_pam_ipp1.nqf_id='0108' AND cqm_pam_ipp1.isactive=1 AND cqm_pam_ipp1.code_type  ='RXNORM'  AND cqm_pam_ipp1.criteriatype='COMMON1' AND cqm_pam_ipp1.isexclude=0 AND cqm_pp_ipp.criteria=1  
           AND pres_ipp.pres_void = 0 AND pd_ipp.history_enabled = 1 
           )PPC on PAT.pa_id=PPC.pa_id   
           WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 6*12 and 12*12   GROUP BY pa_race_type


	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		  select  pa_ethn_type,COUNT(DISTINCT pat.pa_id) sm  from patients PAT inner join (
          SELECT pres_ipp.pa_id FROM  
          prescriptions pres_ipp  
          INNER JOIN prescription_details pd_ipp ON pres_ipp.pres_id=pd_ipp.pres_id 
          INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_ipp.ddid AS VARCHAR)=r1.evd_fdb_vocab_id   
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id    
          INNER JOIN cqm_codes cqm_pam_ipp ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp.code  
          INNER JOIN 	patient_procedures PP_ipp ON PP_ipp.pa_id=pres_ipp.pa_id  AND DATEDIFF(day,pres_ipp.pres_approved_date,PP_ipp.date_performed) BETWEEN 0 AND 30  
          INNER JOIN cqm_codes cqm_pp_ipp ON cqm_pp_ipp.code = PP_ipp.code  

          INNER JOIN patient_active_meds pam_ipp1 ON pres_ipp.pa_id=pam_ipp1.pa_id 
          INNER JOIN revdel0 r1_ipp1 WITH(NOLOCK) ON CAST(pam_ipp1.drug_id AS VARCHAR)=r1_ipp1.evd_fdb_vocab_id   
          INNER JOIN REVDVT0 R2_ipp1 WITH(NOLOCK) ON  r1_ipp1.evd_ext_vocab_type_id=R2_ipp1.evd_vocab_type_id    
          INNER JOIN cqm_codes cqm_pam_ipp1 ON CAST(r1_ipp1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp1.code  


           WHERE PP_ipp.dr_id= @doctorid AND PP_ipp.date_performed between @fromdate AND @todate 
           AND cqm_pam_ipp.version=2 AND cqm_pam_ipp.nqf_id='0108' AND cqm_pam_ipp.isactive=1 AND cqm_pam_ipp.code_type ='RXNORM'  AND cqm_pam_ipp.criteriatype='COMMON1' AND cqm_pam_ipp.isexclude=0 AND cqm_pam_ipp.criteria=1
           AND cqm_pp_ipp.version=2 AND cqm_pp_ipp.nqf_id='0108' AND cqm_pp_ipp.isactive=1 AND cqm_pp_ipp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp_ipp.criteriatype='COMMON1' AND cqm_pp_ipp.isexclude=0 AND cqm_pp_ipp.criteria=3  
           AND cqm_pam_ipp1.version=2 AND cqm_pam_ipp1.nqf_id='0108' AND cqm_pam_ipp1.isactive=1 AND cqm_pam_ipp1.code_type  ='RXNORM'  AND cqm_pam_ipp1.criteriatype='COMMON1' AND cqm_pam_ipp1.isexclude=0 AND cqm_pp_ipp.criteria=1  
           AND pres_ipp.pres_void = 0 AND pd_ipp.history_enabled = 1 
           )PPC on PAT.pa_id=PPC.pa_id   
           WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 6*12 and 12*12   GROUP BY pa_ethn_type
	END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		  select  pa_sex,COUNT(DISTINCT pat.pa_id) sm  from patients PAT inner join (
          SELECT pres_ipp.pa_id FROM  
          prescriptions pres_ipp  
          INNER JOIN prescription_details pd_ipp ON pres_ipp.pres_id=pd_ipp.pres_id 
          INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_ipp.ddid AS VARCHAR)=r1.evd_fdb_vocab_id   
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id    
          INNER JOIN cqm_codes cqm_pam_ipp ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp.code  
          INNER JOIN 	patient_procedures PP_ipp ON PP_ipp.pa_id=pres_ipp.pa_id  AND DATEDIFF(day,pres_ipp.pres_approved_date,PP_ipp.date_performed) BETWEEN 0 AND 30  
          INNER JOIN cqm_codes cqm_pp_ipp ON cqm_pp_ipp.code = PP_ipp.code  

          INNER JOIN patient_active_meds pam_ipp1 ON pres_ipp.pa_id=pam_ipp1.pa_id 
          INNER JOIN revdel0 r1_ipp1 WITH(NOLOCK) ON CAST(pam_ipp1.drug_id AS VARCHAR)=r1_ipp1.evd_fdb_vocab_id   
          INNER JOIN REVDVT0 R2_ipp1 WITH(NOLOCK) ON  r1_ipp1.evd_ext_vocab_type_id=R2_ipp1.evd_vocab_type_id    
          INNER JOIN cqm_codes cqm_pam_ipp1 ON CAST(r1_ipp1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp1.code  


           WHERE PP_ipp.dr_id= @doctorid AND PP_ipp.date_performed between @fromdate AND @todate 
           AND cqm_pam_ipp.version=2 AND cqm_pam_ipp.nqf_id='0108' AND cqm_pam_ipp.isactive=1 AND cqm_pam_ipp.code_type ='RXNORM'  AND cqm_pam_ipp.criteriatype='COMMON1' AND cqm_pam_ipp.isexclude=0 AND cqm_pam_ipp.criteria=1
           AND cqm_pp_ipp.version=2 AND cqm_pp_ipp.nqf_id='0108' AND cqm_pp_ipp.isactive=1 AND cqm_pp_ipp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp_ipp.criteriatype='COMMON1' AND cqm_pp_ipp.isexclude=0 AND cqm_pp_ipp.criteria=3  
           AND cqm_pam_ipp1.version=2 AND cqm_pam_ipp1.nqf_id='0108' AND cqm_pam_ipp1.isactive=1 AND cqm_pam_ipp1.code_type  ='RXNORM'  AND cqm_pam_ipp1.criteriatype='COMMON1' AND cqm_pam_ipp1.isexclude=0 AND cqm_pp_ipp.criteria=1  
           AND pres_ipp.pres_void = 0 AND pd_ipp.history_enabled = 1 
           )PPC on PAT.pa_id=PPC.pa_id   
           WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 6*12 and 12*12   GROUP BY pa_sex
	END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		  select  medicare_type_code,COUNT(DISTINCT pat.pa_id) sm  from patients PAT inner join (
          SELECT pres_ipp.pa_id FROM  
          prescriptions pres_ipp  
          INNER JOIN prescription_details pd_ipp ON pres_ipp.pres_id=pd_ipp.pres_id 
          INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_ipp.ddid AS VARCHAR)=r1.evd_fdb_vocab_id   
          INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id    
          INNER JOIN cqm_codes cqm_pam_ipp ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp.code  
          INNER JOIN 	patient_procedures PP_ipp ON PP_ipp.pa_id=pres_ipp.pa_id  AND DATEDIFF(day,pres_ipp.pres_approved_date,PP_ipp.date_performed) BETWEEN 0 AND 30  
          INNER JOIN cqm_codes cqm_pp_ipp ON cqm_pp_ipp.code = PP_ipp.code  

          INNER JOIN patient_active_meds pam_ipp1 ON pres_ipp.pa_id=pam_ipp1.pa_id 
          INNER JOIN revdel0 r1_ipp1 WITH(NOLOCK) ON CAST(pam_ipp1.drug_id AS VARCHAR)=r1_ipp1.evd_fdb_vocab_id   
          INNER JOIN REVDVT0 R2_ipp1 WITH(NOLOCK) ON  r1_ipp1.evd_ext_vocab_type_id=R2_ipp1.evd_vocab_type_id    
          INNER JOIN cqm_codes cqm_pam_ipp1 ON CAST(r1_ipp1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_ipp1.code  


           WHERE PP_ipp.dr_id= @doctorid AND PP_ipp.date_performed between @fromdate AND @todate 
           AND cqm_pam_ipp.version=2 AND cqm_pam_ipp.nqf_id='0108' AND cqm_pam_ipp.isactive=1 AND cqm_pam_ipp.code_type ='RXNORM'  AND cqm_pam_ipp.criteriatype='COMMON1' AND cqm_pam_ipp.isexclude=0 AND cqm_pam_ipp.criteria=1
           AND cqm_pp_ipp.version=2 AND cqm_pp_ipp.nqf_id='0108' AND cqm_pp_ipp.isactive=1 AND cqm_pp_ipp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp_ipp.criteriatype='COMMON1' AND cqm_pp_ipp.isexclude=0 AND cqm_pp_ipp.criteria=3  
           AND cqm_pam_ipp1.version=2 AND cqm_pam_ipp1.nqf_id='0108' AND cqm_pam_ipp1.isactive=1 AND cqm_pam_ipp1.code_type  ='RXNORM'  AND cqm_pam_ipp1.criteriatype='COMMON1' AND cqm_pam_ipp1.isexclude=0 AND cqm_pp_ipp.criteria=1  
           AND pres_ipp.pres_void = 0 AND pd_ipp.history_enabled = 1 
           )PPC on PAT.pa_id=PPC.pa_id   INNER JOIN vwpatientpayers pyr ON pat.pa_id = pyr.pa_id INNER JOIN cqm_codes cqm_pyr ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591' 
           WHERE DATEDIFF(MONTH,PAT.pa_dob,@fromdate) BETWEEN 6*12 and 12*12   AND  cqm_pyr.version=2 AND cqm_pyr.nqf_id='0108' GROUP BY medicare_type_code
	END 
    
	SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
