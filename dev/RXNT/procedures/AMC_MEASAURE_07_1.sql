SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_07_1]
	-- Add the parameters for the stored procedure here
@drid BIGINT,
@dtstart DATETIME,
@dtend DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    --select Count(distinct r.ad_id) NUMERATOR, COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S left outer join patient_active_meds pad  with(nolock) on s.pa_id = pad.pa_id where pad.date_added between @DTSTART and @DTEND) r
    
    with 
    patient_encounter As (
		SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1
    ),
    
    Denominator_Data As(
        select count(Distinct s.pa_id) denominator_count,@drid As doctorID from patient_encounter  s inner join 
			prescriptions pres  with(nolock) on s.pa_id = pres.pa_id where pres.pres_void = 0 AND pres.pres_entry_date between @DTSTART and @DTEND
			and pres.pres_approved_date is not null
    ),
    
    Numerator_Data As (
		select count(distinct s.pa_id) numerator_count,@drid As doctorID from patient_encounter s inner join 
			prescriptions pres  with(nolock) on s.pa_id = pres.pa_id where pres.pres_void = 0 AND pres.pres_entry_date between @DTSTART and @DTEND
			and pres.pres_approved_date is not null
			
    )
    select denominator_count As DENOMINATOR, numerator_count As NUMERATOR 
    from Denominator_Data DENOM inner join Numerator_Data NUM
    on DENOM.doctorID = NUM.doctorID
    
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
