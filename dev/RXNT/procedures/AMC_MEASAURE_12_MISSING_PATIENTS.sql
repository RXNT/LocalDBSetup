SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_12_MISSING_PATIENTS] 
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
		SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients where pa_id in (select distinct denominator from (select r.ad_id NUMERATOR,r.pa_id DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (  SELECT PA_ID FROM PATIENTS PA WITH(NOLOCK) WHERE PA_ID IN ( SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @dtstart and @dtend and issigned =1))  S left outer join PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on s.pa_id = pad.pa_id and pad.REC_TYPE = 5 and pad.rec_date between @DTSTART and @DTEND) r ) q where q.numerator is null) order by pa_first, pa_last
	END
	ELSE
	BEGIN
		SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients where pa_id in (select distinct denominator from (select r.ad_id NUMERATOR,r.pa_id DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (  SELECT PA_ID FROM PATIENTS PA WITH(NOLOCK) WHERE PA_ID IN ( SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) WHERE DR_ID=@DRID AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 and pres_approved_date between @dtstart and @dtend UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @dtstart and @dtend and issigned =1))  S left outer join PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on s.pa_id = pad.pa_id and pad.REC_TYPE = 5 and pad.rec_date between @DTSTART and @DTEND) r ) q where q.numerator is null) order by pa_first, pa_last
	END
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
