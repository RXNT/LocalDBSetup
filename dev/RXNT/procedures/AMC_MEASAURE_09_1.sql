SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Record and chart changes in vital signs
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_09_1]
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
		--select count(distinct r.ad_id) NUMERATOR,COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S left outer join patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id) r
		select count(distinct r.ad_id) NUMERATOR,COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT E.patient_id pa_id FROM enchanced_encounter e WITH(NOLOCK)INNER JOIN patients pat ON pat.pa_id =E.patient_id WHERE DATEDIFF(MONTH,pat.pa_dob,enc_date)>=2*12 AND E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S left outer join patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
		--AND pad.record_date between @DTSTART and @DTEND 
		AND pad.pa_ht>0 AND pad.pa_wt>0 AND pad.pa_bp_sys>0 AND pad.pa_bp_dys >0) r 
	END
	ELSE
	BEGIN
		--select count(distinct r.ad_id) NUMERATOR,COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) WHERE DR_ID=@DRID  AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  and pres_approved_date between @DTSTART and @DTEND UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S left outer join patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id) r
		select count(distinct r.ad_id) NUMERATOR,COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) WHERE DR_ID=@DRID  AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  and pres_approved_date between @DTSTART and @DTEND UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) INNER JOIN patients pat ON pat.pa_id =e.patient_id WHERE DATEDIFF(MONTH,pa_dob,enc_date)>=2*12 AND E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1) S  left outer join patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
		--AND pad.record_date between @DTSTART and @DTEND 
		AND pad.pa_ht>0 AND pad.pa_wt>0 AND pad.pa_bp_sys>0 AND pad.pa_bp_dys >0 ) r 
	END
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
