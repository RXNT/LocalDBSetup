SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS153v2_NQF0033_POP1_IPP] 
	-- Add the parameters for the stored procedure here
	@doctorid BIGINT , 
	@fromdate DATETIME ,
	@todate DATETIME ,
	@type INT,
	@agefrom INT = 16,
	@ageto INT = 24
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @type = 1 --Patients
	BEGIN
		SELECT DISTINCT PAT.pa_id FROM patients PAT INNER JOIN 
		(
			SELECT pp.pa_id 
			FROM patient_procedures PP INNER JOIN CQM_Codes cqm_pp on PP.code=cqm_pp.code 
			LEFT OUTER JOIN patient_active_diagnosis PAD ON PP.pa_id=PAD.pa_id AND PAD.onset BETWEEN PP.date_performed AND ISNULL(PP.date_performed_to,PP.date_performed)
			LEFT OUTER JOIN CQM_Codes cqm_PAD on cqm_PAD.code=PAD.icd9 AND cqm_pad.version=2 AND cqm_pad.NQF_id='0033' AND cqm_pad.code_type IN('ICD9CM','SNOMEDCT','ICD10CM') AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=4 AND cqm_pad.IsActive=1 AND cqm_pad.IsExclude=0 
			WHERE cqm_PAD.code IS NULL AND cqm_pp.version=2 AND cqm_pp.NQF_id='0033' AND cqm_pp.code_type IN ('CPT','SNOMEDCT') AND cqm_pp.criteriatype='POP1' AND cqm_pp.IsActive=1 AND cqm_pp.IsExclude=0 AND cqm_pp.criteria=3 
			AND dr_id= @doctorid AND PP.date_performed between @fromdate AND @todate 
			GROUP BY pp.pa_id having COUNT(pp.pa_id) > 0
		)PPC on pat.pa_id=PPC.pa_id 
		WHERE PAT.pa_sex='F' AND DATEDIFF(MONTH,pat.pa_dob,@fromdate) BETWEEN 16*12 AND 24*12
	END
	ELSE IF @type = 2 --All
	BEGIN
		SELECT COUNT(DISTINCT pat.pa_id)SM from patients PAT INNER JOIN ( 
        SELECT pp.pa_id from patient_procedures PP  INNER JOIN CQM_Codes cqm_pp on PP.code=cqm_pp.code  
        LEFT OUTER JOIN patient_active_diagnosis PAD ON PP.pa_id=PAD.pa_id AND PAD.onset <@todate 
        LEFT OUTER JOIN CQM_Codes cqm_PAD on (cqm_PAD.code=PAD.icd9 OR PAD.icd10=cqm_pad.CODE OR PAD.snomed_code=cqm_pad.CODE) AND cqm_pad.version=2 AND cqm_pad.NQF_id='0033' AND cqm_pad.code_type IN('ICD9CM','SNOMEDCT','ICD10CM')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=4 AND cqm_pad.IsActive=1 AND cqm_pad.IsExclude=0  
        WHERE  cqm_PAD.code IS NULL AND cqm_pp.version=2 AND cqm_pp.NQF_id='0033' AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1'  AND cqm_pp.IsActive=1 AND cqm_pp.IsExclude=0  AND cqm_pp.criteria=3  
        AND dr_id= @doctorid AND PP.date_performed between @fromdate AND @todate  
        GROUP BY pp.pa_id having COUNT(pp.pa_id) > 0)PPC on pat.pa_id=PPC.pa_id WHERE PAT.pa_sex='F' AND 
        DATEDIFF(MONTH,pat.pa_dob,@fromdate) BETWEEN @agefrom*12 AND @ageto * 12
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		 SELECT pa_race_type ,COUNT(DISTINCT pat.pa_id) SM FROM patients PAT INNER JOIN ( 
          SELECT pp.pa_id from patient_procedures PP  INNER JOIN CQM_Codes cqm_pp on PP.code=cqm_pp.code  
          LEFT OUTER JOIN patient_active_diagnosis PAD ON PP.pa_id=PAD.pa_id AND PAD.onset BETWEEN PP.date_performed AND  ISNULL(PP.date_performed_to,PP.date_performed) 
          LEFT OUTER JOIN CQM_Codes cqm_PAD on cqm_PAD.code=PAD.icd9 AND cqm_pad.version=2 AND cqm_pad.NQF_id='0033' AND cqm_pad.code_type IN('ICD9CM','SNOMEDCT','ICD10CM')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=4 AND cqm_pad.IsActive=1 AND cqm_pad.IsExclude=0  
          WHERE  cqm_PAD.code IS NULL AND cqm_pp.version=2 AND cqm_pp.NQF_id='0033' AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1'  AND cqm_pp.IsActive=1 AND cqm_pp.IsExclude=0  AND cqm_pp.criteria=3  
          AND dr_id=  @doctorid AND PP.date_performed between @fromdate AND @todate  
          GROUP BY pp.pa_id having COUNT(pp.pa_id) > 0)PPC on pat.pa_id=PPC.pa_id WHERE PAT.pa_sex='F' AND 
          DATEDIFF(MONTH,pat.pa_dob,@fromdate) BETWEEN 16*12 AND 24*12  GROUP BY pa_race_type  
                
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		 SELECT pa_ethn_type ,COUNT(DISTINCT pat.pa_id) SM FROM patients PAT INNER JOIN ( 
          SELECT pp.pa_id from patient_procedures PP  INNER JOIN CQM_Codes cqm_pp on PP.code=cqm_pp.code  
          LEFT OUTER JOIN patient_active_diagnosis PAD ON PP.pa_id=PAD.pa_id AND PAD.onset BETWEEN PP.date_performed AND  ISNULL(PP.date_performed_to,PP.date_performed) 
          LEFT OUTER JOIN CQM_Codes cqm_PAD on cqm_PAD.code=PAD.icd9 AND cqm_pad.version=2 AND cqm_pad.NQF_id='0033' AND cqm_pad.code_type IN('ICD9CM','SNOMEDCT','ICD10CM')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=4 AND cqm_pad.IsActive=1 AND cqm_pad.IsExclude=0  
          WHERE  cqm_PAD.code IS NULL AND cqm_pp.version=2 AND cqm_pp.NQF_id='0033' AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1'  AND cqm_pp.IsActive=1 AND cqm_pp.IsExclude=0  AND cqm_pp.criteria=3  
          AND dr_id=  @doctorid AND PP.date_performed between @fromdate AND @todate  
          GROUP BY pp.pa_id having COUNT(pp.pa_id) > 0)PPC on pat.pa_id=PPC.pa_id WHERE PAT.pa_sex='F' AND 
          DATEDIFF(MONTH,pat.pa_dob,@fromdate) BETWEEN 16*12 AND 24*12  GROUP BY pa_ethn_type  

	END
	ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex ,COUNT(DISTINCT pat.pa_id) SM FROM patients PAT INNER JOIN ( 
          SELECT pp.pa_id from patient_procedures PP  INNER JOIN CQM_Codes cqm_pp on PP.code=cqm_pp.code  
          LEFT OUTER JOIN patient_active_diagnosis PAD ON PP.pa_id=PAD.pa_id AND PAD.onset BETWEEN PP.date_performed AND  ISNULL(PP.date_performed_to,PP.date_performed) 
          LEFT OUTER JOIN CQM_Codes cqm_PAD on cqm_PAD.code=PAD.icd9 AND cqm_pad.version=2 AND cqm_pad.NQF_id='0033' AND cqm_pad.code_type IN('ICD9CM','SNOMEDCT','ICD10CM')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=4 AND cqm_pad.IsActive=1 AND cqm_pad.IsExclude=0  
          WHERE  cqm_PAD.code IS NULL AND cqm_pp.version=2 AND cqm_pp.NQF_id='0033' AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1'  AND cqm_pp.IsActive=1 AND cqm_pp.IsExclude=0  AND cqm_pp.criteria=3  
          AND dr_id=  @doctorid AND PP.date_performed between @fromdate AND @todate  
          GROUP BY pp.pa_id having COUNT(pp.pa_id) > 0)PPC on pat.pa_id=PPC.pa_id WHERE PAT.pa_sex='F' AND 
          DATEDIFF(MONTH,pat.pa_dob,@fromdate) BETWEEN 16*12 AND 24*12  GROUP BY pa_sex 
                
	END
	ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code ,COUNT(DISTINCT pat.pa_id) SM FROM patients PAT INNER JOIN ( 
          SELECT pp.pa_id from patient_procedures PP  INNER JOIN CQM_Codes cqm_pp on PP.code=cqm_pp.code  
          LEFT OUTER JOIN patient_active_diagnosis PAD ON PP.pa_id=PAD.pa_id AND PAD.onset BETWEEN PP.date_performed AND  ISNULL(PP.date_performed_to,PP.date_performed) 
          LEFT OUTER JOIN CQM_Codes cqm_PAD on cqm_PAD.code=PAD.icd9 AND cqm_pad.version=2 AND cqm_pad.NQF_id='0033' AND cqm_pad.code_type IN('ICD9CM','SNOMEDCT','ICD10CM')  AND cqm_pad.criteriatype='POP1' AND cqm_pad.criteria=4 AND cqm_pad.IsActive=1 AND cqm_pad.IsExclude=0  
                 
          WHERE  cqm_PAD.code IS NULL AND cqm_pp.version=2 AND cqm_pp.NQF_id='0033' AND cqm_pp.code_type IN ('CPT','SNOMEDCT')  AND cqm_pp.criteriatype='POP1'  AND cqm_pp.IsActive=1 AND cqm_pp.IsExclude=0  AND cqm_pp.criteria=3  
          AND dr_id=  @doctorid AND PP.date_performed between @fromdate AND @todate  
          GROUP BY pp.pa_id having COUNT(pp.pa_id) > 0)PPC on pat.pa_id=PPC.pa_id 
          INNER JOIN vwpatientpayers pyr ON pat.pa_id = pyr.pa_id 
          INNER JOIN cqm_codes cqm_pyr ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591' 
          WHERE PAT.pa_sex='F' AND 
          DATEDIFF(MONTH,pat.pa_dob,@fromdate) BETWEEN 16*12 AND 24*12  AND cqm_pyr.version=2 AND cqm_pyr.nqf_id='0033' GROUP BY medicare_type_code 

	END
	SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
