SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 03/10/2014
-- Description:	Automatic Measure Calculation - Missing Patients
-- =============================================
CREATE PROCEDURE [dbo].[AMC_MEASAURE_14_MISSING_PATIENTS] 
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
		pa_id int
	)

	insert into @Temp
	select distinct denominator from 
			(SELECT pad.pa_id NUMERATOR, pa.pa_id DENOMINATOR 
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
			) q where q.numerator is null
	 
	 UNION
	 
	select distinct denominator from 
			(SELECT DISTINCT pad.pa_id NUMERATOR, pa.pa_id DENOMINATOR 
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
			) q where q.numerator is null 	 
    SET NOCOUNT OFF;
	SELECT  DISTINCT PA_FIRST, PA_LAST, PA_DOB, pa_sex, pa_address1, pa_address2, pa_city, pa_state, pa_zip,pa_ssn from patients P with(nolock) 
		inner join @Temp T on P.pa_id=T.pa_id  order by pa_first, pa_last
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
