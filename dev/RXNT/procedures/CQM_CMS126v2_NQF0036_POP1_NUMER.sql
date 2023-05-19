SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS126v2_NQF0036_POP1_NUMER] 
	-- Add the parameters for the stored procedure here
	@doctorid BIGINT , 
	@fromdate DATETIME ,
	@todate DATETIME ,
	@type INT,
	@agefrom INT=5,--Age in year
	@ageto INT=64
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @type = 2 --All
	BEGIN
		 SELECT COUNT(DISTINCT PAT.PA_ID)SM FROM PATIENTS PAT
		 INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID
		 INNER JOIN CQM_Codes cqm_pp ON PP.CODE=cqm_pp.CODE
		 INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id
		 INNER JOIN CQM_Codes cqm_pad ON (PAD.ICD9=cqm_pad.CODE OR PAD.icd10=cqm_pad.CODE OR PAD.snomed_code=cqm_pad.CODE)
		 --INNER JOIN patient_active_diagnosis pad_excl ON PAT.pa_id=pad_excl.pa_id
		 --INNER JOIN CQM_Codes cqm_pad_excl ON pad_excl.ICD9!=cqm_pad_excl.CODE
		 INNER JOIN prescriptions pres_num ON PAT.pa_id=pres_num.pa_id
		 INNER JOIN prescription_details pd_num ON pres_num.pres_id=pd_num.pres_id  
		 INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_num.ddid AS VARCHAR)=r1.evd_fdb_vocab_id    
		 INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id     
		 INNER JOIN cqm_codes cqm_pam_num ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_num.code   
		 WHERE pp.dr_id= @doctorid and date_performed between @fromdate AND @todate  
		 AND PAD.onset  < @todate
		 AND pres_num.pres_approved_date between @fromdate AND @todate 
		 --AND PAD.onset  between @fromdate AND @todate  AND pad_excl.onset between @fromdate AND @todate
		 AND cqm_pp.version=2 AND cqm_pp.nqf_id='0036' AND cqm_pp.isactive=1 AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1' AND cqm_pp.criteria=2
		 AND cqm_pad.version=2 AND cqm_pad.nqf_id='0036' AND cqm_pad.isactive=1 AND cqm_pad.code_type IN ('ICD10CM','SNOMEDCT')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=1
		 --AND cqm_pad_excl.version=2 AND cqm_pad_excl.nqf_id='0036' AND cqm_pad_excl.isactive=1 AND cqm_pad_excl.code_type IN ('ICD9CM','ICD10CM','SNOMEDCT')  AND cqm_pad_excl.criteriatype='DENOM' AND cqm_pad_excl.isexclude=1
		 AND cqm_pam_num.version=2 AND cqm_pam_num.nqf_id ='0036' AND cqm_pam_num.criteriatype='NUM1' AND cqm_pam_num.code_type='RXNORM'
		 AND pres_num.pres_void = 0 AND pd_num.history_enabled = 1  
		 AND not (pa_dob like '1901-01-01') AND datediff(MONTH,PAT.pa_dob,@fromdate) BETWEEN @agefrom*12 AND @ageto*12

	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		SELECT pa_race_type,COUNT(DISTINCT pat.pa_id) sm FROM PATIENTS PAT
		INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID
		INNER JOIN CQM_Codes cqm_pp ON PP.CODE=cqm_pp.CODE
		INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id
		INNER JOIN CQM_Codes cqm_pad ON PAD.ICD9=cqm_pad.CODE
		--INNER JOIN patient_active_diagnosis pad_excl ON PAT.pa_id=pad_excl.pa_id
		--INNER JOIN CQM_Codes cqm_pad_excl ON PAD.ICD9!=cqm_pad_excl.CODE
		INNER JOIN prescriptions pres_num ON PAT.pa_id=pres_num.pa_id
		INNER JOIN prescription_details pd_num ON pres_num.pres_id=pd_num.pres_id  
		INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_num.ddid AS VARCHAR)=r1.evd_fdb_vocab_id    
		INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id     
		INNER JOIN cqm_codes cqm_pam_num ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_num.code   
		WHERE pp.dr_id= @doctorid and date_performed between @fromdate AND @todate 
		AND PAD.onset  < @todate
		AND pres_num.pres_approved_date between @fromdate AND @todate   
		--AND PAD.onset between @fromdate AND @todate  AND pad_excl.onset between @fromdate AND @todate
		AND cqm_pp.version=2 AND cqm_pp.nqf_id='0036' AND cqm_pp.isactive=1 AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1' AND cqm_pp.criteria=2
		AND cqm_pad.version=2 AND cqm_pad.nqf_id='0036' AND cqm_pad.isactive=1 AND cqm_pad.code_type IN ('ICD10CM','SNOMEDCT')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=1
		--AND cqm_pad_excl.version=2 AND cqm_pad_excl.nqf_id='0036' AND cqm_pad_excl.isactive=1 AND cqm_pad_excl.code_type IN ('ICD9CM','ICD10CM','SNOMEDCT')  AND cqm_pad_excl.criteriatype='DENOM' AND cqm_pad_excl.isexclude=1
		AND datediff(MONTH,PAT.pa_dob,@fromdate)  BETWEEN 5*12 AND 64*12  AND not (pa_dob like '1901-01-01')
		AND pres_num.pres_void = 0 AND pd_num.history_enabled = 1  
		AND cqm_pam_num.version=2 AND cqm_pam_num.nqf_id ='0036' AND cqm_pam_num.criteriatype='NUM1' AND cqm_pam_num.code_type='RXNORM' GROUP BY pa_race_type
		            
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type,COUNT(DISTINCT pat.pa_id) sm FROM PATIENTS PAT
        INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID
        INNER JOIN CQM_Codes cqm_pp ON PP.CODE=cqm_pp.CODE
        INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id
        INNER JOIN CQM_Codes cqm_pad ON PAD.ICD9=cqm_pad.CODE
        --INNER JOIN patient_active_diagnosis pad_excl ON PAT.pa_id=pad_excl.pa_id
        --INNER JOIN CQM_Codes cqm_pad_excl ON PAD.ICD9!=cqm_pad_excl.CODE
        INNER JOIN prescriptions pres_num ON PAT.pa_id=pres_num.pa_id
		INNER JOIN prescription_details pd_num ON pres_num.pres_id=pd_num.pres_id  
		INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_num.ddid AS VARCHAR)=r1.evd_fdb_vocab_id    
		INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id     
		INNER JOIN cqm_codes cqm_pam_num ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_num.code   
        WHERE pp.dr_id= @doctorid and date_performed between @fromdate AND @todate 
        AND PAD.onset < @todate
        AND pres_num.pres_approved_date between @fromdate AND @todate 
        --AND PAD.onset between @fromdate AND @todate  AND pad_excl.onset between @fromdate AND @todate
        AND cqm_pp.version=2 AND cqm_pp.nqf_id='0036' AND cqm_pp.isactive=1 AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1' AND cqm_pp.criteria=2
        AND cqm_pad.version=2 AND cqm_pad.nqf_id='0036' AND cqm_pad.isactive=1 AND cqm_pad.code_type IN ('ICD10CM','SNOMEDCT')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=1
        --AND cqm_pad_excl.version=2 AND cqm_pad_excl.nqf_id='0036' AND cqm_pad_excl.isactive=1 AND cqm_pad_excl.code_type IN ('ICD9CM','ICD10CM','SNOMEDCT')  AND cqm_pad_excl.criteriatype='DENOM' AND cqm_pad_excl.isexclude=1
        AND datediff(MONTH,PAT.pa_dob,@fromdate)  BETWEEN 5*12 AND 64*12  AND not (pa_dob like '1901-01-01')
        AND pres_num.pres_void = 0 AND pd_num.history_enabled = 1  
        AND cqm_pam_num.version=2 AND cqm_pam_num.nqf_id ='0036' AND cqm_pam_num.criteriatype='NUM1' AND cqm_pam_num.code_type='RXNORM'  GROUP BY pa_ethn_type 
                    
	END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex,COUNT(DISTINCT pat.pa_id) sm FROM PATIENTS PAT
        INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID
        INNER JOIN CQM_Codes cqm_pp ON PP.CODE=cqm_pp.CODE
        INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id
        INNER JOIN CQM_Codes cqm_pad ON PAD.ICD9=cqm_pad.CODE
        --INNER JOIN patient_active_diagnosis pad_excl ON PAT.pa_id=pad_excl.pa_id
        --INNER JOIN CQM_Codes cqm_pad_excl ON PAD.ICD9!=cqm_pad_excl.CODE
        INNER JOIN prescriptions pres_num ON PAT.pa_id=pres_num.pa_id
     INNER JOIN prescription_details pd_num ON pres_num.pres_id=pd_num.pres_id  
     INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_num.ddid AS VARCHAR)=r1.evd_fdb_vocab_id    
     INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id     
     INNER JOIN cqm_codes cqm_pam_num ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_num.code   
        WHERE pp.dr_id= @doctorid and date_performed between @fromdate AND @todate 
        AND PAD.onset < @todate
        AND pres_num.pres_approved_date between @fromdate AND @todate  
        --AND PAD.onset between @fromdate AND @todate  AND pad_excl.onset between @fromdate AND @todate
        AND cqm_pp.version=2 AND cqm_pp.nqf_id='0036' AND cqm_pp.isactive=1 AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1' AND cqm_pp.criteria=2
        AND cqm_pad.version=2 AND cqm_pad.nqf_id='0036' AND cqm_pad.isactive=1 AND cqm_pad.code_type IN ('ICD10CM','SNOMEDCT')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=1
        --AND cqm_pad_excl.version=2 AND cqm_pad_excl.nqf_id='0036' AND cqm_pad_excl.isactive=1 AND cqm_pad_excl.code_type IN ('ICD9CM','ICD10CM','SNOMEDCT')  AND cqm_pad_excl.criteriatype='DENOM' AND cqm_pad_excl.isexclude=1
        AND datediff(MONTH,PAT.pa_dob,@fromdate)  BETWEEN 5*12 AND 64*12  AND not (pa_dob like '1901-01-01')
        AND pres_num.pres_void = 0 AND pd_num.history_enabled = 1  
        AND cqm_pam_num.version=2 AND cqm_pam_num.nqf_id ='0036' AND cqm_pam_num.criteriatype='NUM1' AND cqm_pam_num.code_type='RXNORM' GROUP BY pa_sex
                    
	END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id)SM FROM PATIENTS PAT
        INNER JOIN PATIENT_PROCEDURES PP ON PAT.PA_ID=PP.PA_ID
        INNER JOIN CQM_Codes cqm_pp ON PP.CODE=cqm_pp.CODE
        INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id
        INNER JOIN CQM_Codes cqm_pad ON PAD.ICD9=cqm_pad.CODE
        --INNER JOIN patient_active_diagnosis pad_excl ON PAT.pa_id=pad_excl.pa_id
        --INNER JOIN CQM_Codes cqm_pad_excl ON PAD.ICD9!=cqm_pad_excl.CODE
        INNER JOIN prescriptions pres_num ON PAT.pa_id=pres_num.pa_id
        INNER JOIN prescription_details pd_num ON pres_num.pres_id=pd_num.pres_id  
        INNER JOIN revdel0 r1 WITH(NOLOCK) ON CAST(pd_num.ddid AS VARCHAR)=r1.evd_fdb_vocab_id    
        INNER JOIN REVDVT0 R2 WITH(NOLOCK) ON  r1.evd_ext_vocab_type_id=r2.evd_vocab_type_id     
        INNER JOIN cqm_codes cqm_pam_num ON CAST(R1.EVD_EXT_VOCAB_ID AS VARCHAR)= cqm_pam_num.code   
        INNER JOIN vwpatientpayers pyr ON pat.pa_id = pyr.pa_id
        INNER JOIN cqm_codes cqm_pyr ON pp.code=cqm_pyr.code 
        WHERE cqm_pyr.version=2 AND cqm_pyr.nqf_id='0036' AND pp.dr_id= @doctorid and date_performed between @fromdate AND @todate 
        AND PAD.onset < @todate
        AND pres_num.pres_approved_date between @fromdate AND @todate 
        --AND PAD.onset between @fromdate AND @todate  AND pad_excl.onset between @fromdate AND @todate
        AND cqm_pp.version=2 AND cqm_pp.nqf_id='0036' AND cqm_pp.isactive=1 AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1' AND cqm_pp.criteria=2
        AND cqm_pad.version=2 AND cqm_pad.nqf_id='0036' AND cqm_pad.isactive=1 AND cqm_pad.code_type IN ('ICD10CM','SNOMEDCT')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=1
        --AND cqm_pad_excl.version=2 AND cqm_pad_excl.nqf_id='0036' AND cqm_pad_excl.isactive=1 AND cqm_pad_excl.code_type IN ('ICD9CM','ICD10CM','SNOMEDCT')  AND cqm_pad_excl.criteriatype='DENOM' AND cqm_pad_excl.isexclude=1
        AND datediff(MONTH,PAT.pa_dob,@fromdate)  BETWEEN 5*12 AND 64*12  AND not (pa_dob like '1901-01-01')
        AND pres_num.pres_void = 0 AND pd_num.history_enabled = 1  
        AND cqm_pam_num.version=2 AND cqm_pam_num.nqf_id ='0036' AND cqm_pam_num.criteriatype='NUM1' AND cqm_pam_num.code_type='RXNORM' GROUP BY medicare_type_code
                            
	END
	SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
