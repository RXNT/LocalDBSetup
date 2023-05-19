SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 10-May-2016
-- Description:	Search Patient Vitals
-- =============================================

CREATE PROCEDURE [dbo].[usp_SearchPatientVitals]
(
@PatientId BIGINT,
@DoctorGroupId BIGINT,
@RecentOnly BIT
)
AS
BEGIN
  IF ISNULL(@RecentOnly,0) = 0
  BEGIN
	SELECT
	 [pa_vt_id],
	 pv.[pa_id],
	 [pa_wt],
	 pv.[pa_ht],
	 [pa_pulse],
	 [pa_bp_sys],
	 [pa_bp_dys],
	 [pa_glucose],
	 [pa_hc],
	 [pa_resp_rate],
	 [pa_temp],
	 [pa_bmi],
	 [age],
	 [date_added],
	 pv.[dg_id],
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
	 p.pa_dob,
	 ISNULL(dr.DR_PREFIX,'') + ' ' + ISNULL(dr.DR_FIRST_NAME,'') + ' ' + ISNULL(dr.DR_MIDDLE_INITIAL,'') + ' ' + ISNULL(dr.DR_LAST_NAME,'') + ' ' + ISNULL(dr.DR_SUFFIX,'') AS 'PrintedName'  , pv.visibility_hidden_to_patient
	 FROM [dbo].[patient_vitals] pv
	 INNER JOIN [dbo].[doctors] dr ON pv.added_by = dr.dr_id
	 INNER JOIN [dbo].[patients] p ON pv.pa_id=p.pa_id
	 WHERE pv.PA_ID = @PatientId and pv.dg_id = @DoctorGroupId 
	 ORDER BY RECORD_DATE DESC, AGE DESC, pa_vt_id DESC
  END
  ELSE
  BEGIN
	SELECT TOP 1
	 [pa_vt_id],
	 pv.[pa_id],
	 [pa_wt],
	 pv.[pa_ht],
	 [pa_pulse],
	 [pa_bp_sys],
	 [pa_bp_dys],
	 [pa_glucose],
	 [pa_hc],
	 [pa_resp_rate],
	 [pa_temp],
	 [pa_bmi],
	 [age],
	 [date_added],
	 pv.[dg_id],
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
	 p.pa_dob,
	 ISNULL(dr.DR_PREFIX,'') + ' ' + ISNULL(dr.DR_FIRST_NAME,'') + ' ' + ISNULL(dr.DR_MIDDLE_INITIAL,'') + ' ' + ISNULL(dr.DR_LAST_NAME,'') + ' ' + ISNULL(dr.DR_SUFFIX,'') AS 'PrintedName'  , pv.visibility_hidden_to_patient
	 FROM [dbo].[patient_vitals] pv
	 INNER JOIN [dbo].[patients] p ON pv.pa_id=p.pa_id
	 INNER JOIN [dbo].[doctors] dr ON pv.added_by = dr.dr_id
	 WHERE pv.PA_ID = @PatientId and pv.dg_id = @DoctorGroupId 
	 ORDER BY RECORD_DATE DESC, AGE DESC, PA_VT_ID DESC
  END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
