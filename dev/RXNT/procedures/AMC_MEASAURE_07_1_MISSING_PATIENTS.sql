SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_07_1_MISSING_PATIENTS] 
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
  
  with 
    patient_encounter As (
		SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1
    ),
    
    Denominator_Data As(
        select Distinct s.pa_id denominator_patient,@drid As doctorID from patient_encounter s inner join 
			prescriptions pres  with(nolock) on s.pa_id = pres.pa_id where pres.pres_void = 0 AND pres.pres_entry_date between @DTSTART and @DTEND
			and pres.pres_approved_date is not null
    ),
    
    Numerator_Data As (
		select distinct s.pa_id numerator_patient,@drid As doctorID from patient_encounter s inner join 
			prescriptions pres  with(nolock) on s.pa_id = pres.pa_id where pres.pres_void = 0 AND pres.pres_entry_date between @DTSTART and @DTEND
			and pres.pres_approved_date is not null
			
    )
    select PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients P with(nolock)
    where P.pa_id in (select denominator_patient from Denominator_Data )
    And P.pa_id not in (select numerator_patient from Numerator_Data )  
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
