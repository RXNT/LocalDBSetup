SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12/18/2014
-- Description:	To get the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [dbo].[CQM_CMS68v3_NQF0419_POP1_IPP] 
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

    -- Insert statements for procedure here
    IF @type = 1 --Patients
	BEGIN
		SELECT DISTINCT pat.pa_id 
		FROM patients pat with(nolock)
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
		WHERE cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type='CPT' 
		AND cqm.criteriatype='POP1' AND cqm.isactive=1 AND cqm.isexclude=0
		AND pp.dr_id = @doctorid AND pp.date_performed BETWEEN @fromdate AND @todate
		AND  DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12
	END
    ELSE IF @type = 2 --All
	BEGIN
		SELECT COUNT(pp.code)SM 
		FROM patients pat with(nolock)
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id 
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code 
		WHERE cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type='CPT' 
		AND cqm.criteriatype='POP1' AND cqm.isactive=1 AND cqm.isexclude=0 
		AND pp.dr_id = @doctorid AND pp.date_performed BETWEEN @fromdate AND @todate 
		AND DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12 
	END
	ELSE IF @type = 3 --Race Wise
	BEGIN
		SELECT pa_race_type ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients pat with(nolock)
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
		WHERE cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type='CPT'
		AND cqm.criteriatype='POP1' AND cqm.isactive=1 AND cqm.isexclude=0 
		AND pp.dr_id = @doctorid AND pp.date_performed BETWEEN @fromdate AND @todate 
		AND not(pa_race_type is null)
		AND  DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12
		GROUP BY pa_race_type 
	END
	ELSE IF @type = 4 --Ethnicity Wise
	BEGIN
		SELECT pa_ethn_type ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients pat with(nolock)
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
		WHERE cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type='CPT'
		AND cqm.criteriatype='POP1' AND cqm.isactive=1 AND cqm.isexclude=0 
		AND pp.dr_id = @doctorid AND pp.date_performed BETWEEN @fromdate AND @todate 
		AND not(pa_ethn_type is null)
		AND  DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12
    GROUP BY pa_ethn_type 
    END
    ELSE IF @type = 5 --Gender Wise
	BEGIN
		SELECT pa_sex ,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients pat with(nolock)
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
		WHERE cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type='CPT'
		AND cqm.criteriatype='POP1' AND cqm.isactive=1 AND cqm.isexclude=0 
		AND pp.dr_id = @doctorid AND pp.date_performed BETWEEN @fromdate AND @todate 
		AND not(pa_sex is null)
		AND  DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12
		GROUP BY pa_sex 
    END
    ELSE IF @type = 6 --Payer Wise
	BEGIN
		SELECT medicare_type_code,COUNT(DISTINCT pat.pa_id) SM 
		FROM patients pat with(nolock)
		INNER JOIN patient_procedures pp with(nolock) ON pat.pa_id=pp.pa_id
		INNER JOIN cqm_codes cqm with(nolock) ON pp.code=cqm.code
		INNER JOIN vwpatientpayers pyr with(nolock) ON pat.pa_id = pyr.pa_id 
		INNER JOIN cqm_codes cqm_pyr with(nolock) ON pyr.medicare_type_code = cqm_pyr.code AND cqm_pyr.value_set_oid='2.16.840.1.114222.4.11.3591'
		WHERE cqm_pyr.version=2 AND cqm_pyr.nqf_id='0419' AND cqm.version=2 AND cqm.nqf_id='0419' AND cqm.code_type='CPT'
		AND cqm.criteriatype='POP1' AND cqm.isactive=1 AND cqm.isexclude=0 
		AND pp.dr_id = @doctorid AND pp.date_performed BETWEEN @fromdate AND @todate 
		AND not(medicare_type_code is null)
		AND  DATEDIFF(MONTH,pat.pa_dob,@fromdate) >= 18*12
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
