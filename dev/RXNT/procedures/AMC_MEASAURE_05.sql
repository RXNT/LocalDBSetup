SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Rasheed  
-- Create date: 03/10/2014  
-- Description: Automatic Measure Calculation - Missing Patients  
-- =============================================  
CREATE PROCEDURE [dbo].[AMC_MEASAURE_05]  
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
		SELECT  COUNT(distinct r.pa_id) numerator, COUNT(distinct s.pa_id) denominator  from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and e.enc_date between @DTSTART and @DTEND and issigned =1 ) S left outer join (select * from patient_measure_compliance pad with(nolock) where pad.rec_date between @DTSTART and @DTEND and pad.rec_type = 2 and dr_id =@DRID) r on s.pa_id = r.pa_id   
	END  
	ELSE  
	BEGIN  
		SELECT  COUNT(distinct r.pa_id) numerator, COUNT(distinct s.pa_id) denominator  from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) where pres_approved_date between @DTSTART and @DTEND AND PRES_PRESCRIPTION_TYPE = 1  and DR_ID=@DRID UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and e.enc_date between @DTSTART and @DTEND and issigned =1 ) S left outer join (select * from patient_measure_compliance pad with(nolock) where pad.rec_date between @DTSTART and @DTEND and pad.rec_type = 2 and dr_id =@DRID) r on s.pa_id = r.pa_id   
	END  
    SET NOCOUNT OFF;  
END  
  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
