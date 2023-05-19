SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_02]
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
		--select Count(distinct r.ad_id) NUMERATOR, COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S left outer join patient_active_meds pad  with(nolock) on s.pa_id = pad.pa_id) r
		select Count(distinct r.ad_id) NUMERATOR, COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pmc.pa_id ad_id from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S left outer join patient_measure_compliance pmc with(nolock)  on s.pa_id = pmc.pa_id AND pmc.rec_type=7 AND pmc.rec_date <= @DTEND) r
	END
	ELSE
	BEGIN
		--select Count(distinct r.ad_id) NUMERATOR, COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) WHERE DR_ID=@DRID and pres_approved_date between @DTSTART and @DTEND AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S left outer join patient_active_meds pad  with(nolock) on s.pa_id = pad.pa_id) r
		select Count(distinct r.ad_id) NUMERATOR, COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pmc.pa_id ad_id from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) WHERE DR_ID=@DRID and pres_approved_date between @DTSTART and @DTEND AND PRES_VOID = 0  AND PRES_PRESCRIPTION_TYPE = 1 UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE enc_date between @DTSTART and @DTEND and E.dr_id = @DRID and issigned =1) S left outer join patient_measure_compliance pmc with(nolock)  on s.pa_id = pmc.pa_id AND pmc.rec_type=7 AND pmc.rec_date <= @DTEND) r
	END
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
