SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 31-May-2016
-- Description:	Get Patient Vitals
-- =============================================

CREATE   PROCEDURE [dbo].[usp_GetPatientVitals]
(
	@PatientVitalsId INT
)
AS
BEGIN
	SELECT [pa_vt_id],
		   [pa_id],
		   [pa_wt],
		   [pa_ht],
		   [pa_pulse],
		   [pa_bp_sys],
		   [pa_bp_dys],
		   [pa_glucose],
		   [pa_hc],
		   [pa_resp_rate],
		   [pa_temp],
		   [pa_bmi],
		   [age],
		   [date_added],pv.
		   [dg_id],
		   [added_by],
		   [added_for],
		   [record_date],
		   [pa_oxm],
		   [pa_bp_location],
		   [pa_bp_sys_statnding],
		   [pa_bp_dys_statnding],
		   [pa_bp_location_statnding],
		   [pa_bp_sys_supine],
		   [pa_bp_dys_supine],
		   [pa_bp_location_supine],
		   [pa_temp_method],
		   [pa_pulse_rhythm],
		   [pa_pulse_standing],
		   [pa_pulse_rhythm_standing],
		   [pa_pulse_supine],
		   [pa_pulse_rhythm_supine],
		   [pa_heart_rate],
		   [pa_fio2],
		   [pa_flow],
		   [pa_resp_quality],
		   [pa_comment],
		   [BmiPercentile],
		   [HeadCircumferencePercentile],
		   [WeightLengthPercentile],
		   ISNULL(dr.DR_PREFIX,'') + ' ' + ISNULL(dr.DR_FIRST_NAME,'') + ' ' + ISNULL(dr.DR_MIDDLE_INITIAL,'') + ' ' + ISNULL(dr.DR_LAST_NAME,'') + ' ' + ISNULL(dr.DR_SUFFIX,'') AS 'PrintedName'    
	FROM [RxNT].[dbo].[patient_vitals] pv with(nolock)
	INNER JOIN [RxNT].[dbo].[doctors] dr with(nolock) ON pv.added_by = dr.dr_id
	WHERE PA_vt_id = @PatientVitalsId  
	ORDER BY AGE, RECORD_DATE
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
