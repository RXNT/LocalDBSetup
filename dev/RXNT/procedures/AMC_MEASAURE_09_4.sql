SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Record and chart changes in vital signs
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_09_4]
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
	select 
	count(distinct r.ad_id) NUMERATOR,
	COUNT(distinct r.pa_id) DENOMINATOR from 
		(SELECT distinct s.pa_id, pad.pa_id ad_id  from 
			(SELECT E.patient_id pa_id,MAX(e.enc_date)encounter_date,MAX(pat.pa_dob) pa_dob FROM 
			enchanced_encounter e WITH(NOLOCK)INNER JOIN 
			patients pat WITH(NOLOCK) ON pat.pa_id =E.patient_id 
			WHERE E.dr_id = @DRID and enc_date between @DTSTART and @DTEND and issigned =1 group by E.patient_id) S
		left outer join  patient_vitals pad with(nolock)  on s.pa_id = pad.pa_id 
		-- AND pad.record_date between @DTSTART and @DTEND 
		AND CASE WHEN (DATEDIFF(MONTH,S.pa_dob,S.encounter_date)>=12*2 OR pad.pa_bp_sys>0) THEN 1 ELSE 0 END >0) r 
    SET NOCOUNT OFF;
    
     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
