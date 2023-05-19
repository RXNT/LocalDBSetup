SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_07_MISSING_PATIENTS] 
	-- Add the parameters for the stored procedure here
@drid BIGINT,
@dtstart DATETIME,
@dtend DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    --SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip from patients where pa_id in (select distinct denominator from (select r.ad_id NUMERATOR, r.pa_id DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S left outer join patient_active_meds pad  with(nolock) on s.pa_id = pad.pa_id where pad.date_added between @DTSTART and @DTEND) r) q where q.numerator is null) order by pa_first, pa_last
    SELECT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients
	where pa_id in (select distinct denominator from (
	select CASE WHEN r.type=1 THEN r.ad_id ELSE NULL END   NUMERATOR, r.pa_id DENOMINATOR from (
    SELECT distinct s.pa_id, pres.pa_id ad_id,1 AS type from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S INNER join prescriptions pres  with(nolock) on s.pa_id = pres.pa_id where pres_void = 0 AND pres.pres_entry_date between @DTSTART and @DTEND and not(pres.pres_approved_date is null)
    UNION 
    SELECT distinct s.pa_id, pam.pa_id ad_id,2 AS type from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S INNER join patient_medications_hx pam with(nolock)  on s.pa_id = pam.pa_id  AND pam.date_added between @DTSTART and @DTEND 
    ) r
  ) q where q.numerator is  null) order by pa_first, pa_last
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
