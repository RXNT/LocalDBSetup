SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      
      
-- =============================================      
-- Author:  Rasheed      
-- Create date: 03/10/2014      
-- Description: Automatic Measure Calculation - Missing Patients      
-- =============================================      
CREATE PROCEDURE [dbo].[AMC_MEASAURE_13]      
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
		select coalesce(count(distinct(s.pa_id)),0) numerator,count(DISTINCT r.pa_id) denominator from (SELECT distinct PA_ID, MAX(ENC_DATE) ENC_DATE FROM (select patient_id pa_id, MAX(enc_date) enc_date from enchanced_encounter  with(nolock) where dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 And type_of_visit like 'OFICE' group by patient_id, enc_date) S GROUP BY S.pa_id) R left outer join (select distinct pa_id,rec_date from patient_measure_compliance where rec_date between @dtstart and @dtend and rec_type =5 ) s on r.pa_id = s.pa_id   
	END      
	ELSE      
	BEGIN      
		select coalesce(count(distinct(s.pa_id)),0) numerator,count(DISTINCT r.pa_id) denominator from (SELECT distinct PA_ID, MAX(ENC_DATE) ENC_DATE FROM ( SELECT pa_id, MAX(pres_approved_date) enc_date FROM  prescriptions with(nolock) where dr_id = @DRID AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  and pres_approved_date between @DTSTART and @DTEND group by pa_id,pres_approved_date union select patient_id pa_id, MAX(enc_date) enc_date from enchanced_encounter  with(nolock) where dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 And type_of_visit like 'OFICE' group by patient_id, enc_date) S GROUP BY S.pa_id) R left outer join ( select distinct pa_id,rec_date from patient_measure_compliance where rec_date between @dtstart and @dtend and rec_type =5  ) s on r.pa_id = s.pa_id 
	END      
	SET NOCOUNT OFF;      
END      
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
