SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_07_2]
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
    select Count( CASE WHEN r.type=1 THEN r.ad_id ELSE NULL END)   NUMERATOR, Count(r.ad_id )  DENOMINATOR from (
    SELECT distinct pa_id, pres.pres_id ad_id,1 AS type from prescriptions pres  with(nolock) where pres_void = 0 AND pres.pres_entry_date between @DTSTART and @DTEND AND dr_id=@DRID And (pres.pres_approved_date is not null)
    UNION 
    SELECT distinct pa_id, pam.pam_id ad_id,2 AS type from patient_medications_hx pam with(nolock)  where pam.date_added between @DTSTART and @DTEND AND (added_by_dr_id=@DRID or for_dr_id=@DRID)
    ) r

    SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
