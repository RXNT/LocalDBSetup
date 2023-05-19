SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_05_MISSING_PATIENTS] 
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
		SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients where pa_id in ( select distinct denominator from (SELECT  r.pa_id numerator, s.pa_id denominator  from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and e.enc_date between @DTSTART and @DTEND and issigned =1) S left outer join (select * from patient_measure_compliance pad with(nolock) where pad.rec_date between @DTSTART and @DTEND and pad.rec_type = 2 and dr_id =@DRID) r on s.pa_id = r.pa_id ) q where q.numerator is null) order by pa_first, pa_last
	END
	ELSE
	BEGIN
		SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients where pa_id in ( select distinct denominator from (SELECT  r.pa_id numerator, s.pa_id denominator  from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) where pres_approved_date between @DTSTART and @DTEND AND PRES_PRESCRIPTION_TYPE = 1  and DR_ID=@DRID UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and e.enc_date between @DTSTART and @DTEND and issigned =1 ) S left outer join (select * from patient_measure_compliance pad with(nolock) where pad.rec_date between @DTSTART and @DTEND and pad.rec_type = 2 and dr_id =@DRID) r on s.pa_id = r.pa_id ) q where q.numerator is null) order by pa_first, pa_last
	END
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
