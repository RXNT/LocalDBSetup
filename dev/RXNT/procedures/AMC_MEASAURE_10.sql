SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_10]
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
		select count(distinct r.ad_id) NUMERATOR,COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM PATIENTS WHERE DATEDIFF(YYYY, PA_DOB, GETDATE()) >= 13 AND PA_ID IN (SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1)) S left outer join patient_flag_details pad with(nolock)  on s.pa_id = pad.pa_id and ((pad.flag_id between 5 and 8) OR pad.flag_id < 0)) r
	END
	ELSE
	BEGIN
		select count(distinct r.ad_id) NUMERATOR,COUNT(distinct r.pa_id) DENOMINATOR from (SELECT distinct s.pa_id, pad.pa_id ad_id  from (SELECT DISTINCT PA_ID FROM PATIENTS WHERE DATEDIFF(YYYY, PA_DOB, GETDATE()) >= 13 AND PA_ID IN (SELECT DISTINCT PA_ID FROM prescriptions P WITH(NOLOCK) WHERE DR_ID=@DRID AND PRES_PRESCRIPTION_TYPE = 1 AND PRES_VOID = 0  AND pres_approved_date between @DTSTART and @DTEND UNION SELECT DISTINCT E.patient_id FROM enchanced_encounter e WITH(NOLOCK) WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1)) S left outer join patient_flag_details pad with(nolock)  on s.pa_id = pad.pa_id and ((pad.flag_id between 5 and 8) OR pad.flag_id < 0)) r
	END
    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
