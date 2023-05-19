SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
    
-- =============================================    
-- Author:  Rasheed    
-- Create date: 03/10/2014    
-- Description: Automatic Measure Calculation - Missing Patients    
-- =============================================    
CREATE PROCEDURE [dbo].[AMC_MEASAURE_13_MISSING_PATIENTS]     
 -- Add the parameters for the stored procedure here    
@encounteronly BIT,    
@drid BIGINT,    
@dtstart DATETIME,    
@dtend DATETIME    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;    
    
	IF @encounteronly=1    
	BEGIN    
		SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients where pa_id in (select distinct denominator from ( select distinct s.pa_id numerator,r.pa_id denominator from (SELECT distinct PA_ID, MAX(ENC_DATE) ENC_DATE FROM (select patient_id pa_id, MAX(enc_date) enc_date from enchanced_encounter  with(nolock) where dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 And type_of_visit like 'OFICE' group by patient_id, enc_date) S GROUP BY S.pa_id) R left outer join (select distinct pa_id,rec_date from patient_measure_compliance where rec_date between @dtstart and @dtend and rec_type =5 ) s on r.pa_id = s.pa_id ) q where q.numerator is null) order by pa_first, pa_last    
	END    
	ELSE    
	BEGIN    
		SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients where pa_id in (select distinct denominator from ( select distinct s.pa_id  numerator, r.pa_id denominator from(SELECT distinct PA_ID, MAX(ENC_DATE) ENC_DATE FROM ( SELECT pa_id, MAX(pres_approved_date) enc_date FROM  prescriptions with(nolock) where dr_id = @DRID AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  and pres_approved_date between @DTSTART and @DTEND	group by pa_id,pres_approved_date union select patient_id pa_id, MAX(enc_date) enc_date from enchanced_encounter  with(nolock) where dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 And type_of_visit like 'OFICE' group by patient_id, enc_date) S GROUP BY S.pa_id)R left outer join ( select distinct pa_id,rec_date from patient_measure_compliance where rec_date between @dtstart and @dtend and rec_type =5 ) s on r.pa_id = s.pa_id ) q where q.numerator is null) order by pa_first, pa_last    
	END    
	SET NOCOUNT OFF;    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
