SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation
-- Revision : 10-21-2014 (ED-561)
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_14]
	-- Add the parameters for the stored procedure here
@drid BIGINT,
@dtstart DATETIME,
@dtend DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Temp TABLE
	(
		NUMPATIENT BIGINT,
		DENOMPATIENT BIGINT
	)
	INSERT INTO @Temp
		SELECT 
		case when pad.pa_id is null then 0 ELSE pad.pa_id END NUMPATIENT,
		case when pa.pa_id > 0 THEN pa.pa_id ELSE 0 END DENOMPATIENT
		FROM PATIENTS PA WITH(NOLOCK) 
		INNER JOIN enchanced_encounter pen with(nolock) ON pen.patient_id=PA.pa_id
		LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS paext with(nolock) on paext.pa_id=PA.pa_id
		LEFT OUTER JOIN patient_flag_details PFD WITH(NOLOCK) ON PA.pa_id=PFD.pa_id
		LEFT OUTER JOIN PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on pa.pa_id = pad.pa_id 
		AND pad.REC_TYPE = 3 and pad.rec_date between @DTSTART and @DTEND
		WHERE 
		--d.dr_id=@DRID AND 
		PA.dg_id in 
		(select dg.dg_id from doc_groups dg where dc_id in 
			(select DG.dc_id from doctors DR with(nolock) 
				inner join doc_groups DG with(nolock) on DR.dg_id=DG.dg_id 
				inner join doc_companies DC with(nolock) on Dg.dc_id=DC.dc_id where DR.dr_id=@drid)
		)
		AND not(PA_DOB between DATEADD(MM,-(65*12),@dtend) AND DATEADD(MM,-(5*12),@dtend))
		and (PFD.flag_id is null or PFD.flag_id <> 3) and (paext.comm_pref IS NULL OR paext.comm_pref <> 255)
		
		UNION
		
		SELECT 
		case when pad.pa_id is null then 0 ELSE pad.pa_id END NUMPATIENT,
		case when pa.pa_id > 0 THEN pa.pa_id ELSE 0 END DENOMPATIENT 
		FROM PATIENTS PA WITH(NOLOCK) 
		INNER JOIN prescriptions   p   with(nolock)    ON p.pa_id=PA.pa_id
		LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS paext with(nolock) on paext.pa_id=PA.pa_id
		LEFT OUTER JOIN patient_flag_details PFD WITH(NOLOCK) ON PA.pa_id=PFD.pa_id
		LEFT OUTER JOIN PATIENT_MEASURE_COMPLIANCE pad with(nolock)  on pa.pa_id = pad.pa_id 
		AND pad.REC_TYPE = 3 and pad.rec_date between @DTSTART and @DTEND
		WHERE 
		--d.dr_id=@DRID AND 
		PA.dg_id in 
		(select dg.dg_id from doc_groups dg where dc_id in 
			(select DG.dc_id from doctors DR with(nolock) 
				inner join doc_groups DG with(nolock) on DR.dg_id=DG.dg_id 
				inner join doc_companies DC with(nolock) on Dg.dc_id=DC.dc_id where DR.dr_id=@drid)
		)
		AND not(PA_DOB between DATEADD(MM,-(65*12),@dtend) AND DATEADD(MM,-(5*12),@dtend))
		and (PFD.flag_id is null or PFD.flag_id <> 3) and (paext.comm_pref IS NULL OR paext.comm_pref <> 255)
    SET NOCOUNT OFF;
    SELECT (SELECT COUNT(distinct NUMPATIENT) FROM @Temp WHERE NUMPATIENT > 0) AS NUMERATOR,
	(SELECT COUNT(distinct DENOMPATIENT) FROM @Temp WHERE DENOMPATIENT > 0)DENOMINATOR
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
