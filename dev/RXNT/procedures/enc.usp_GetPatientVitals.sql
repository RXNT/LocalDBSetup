SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To get the patient allergies
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPatientVitals]
	@PatientId BIGINT,
	@VitalsId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1 [pa_vt_id],[pa_id],[pa_wt],[pa_ht],[pa_pulse],[pa_bp_sys],[pa_bp_dys],[pa_glucose],[pa_hc],[pa_resp_rate],[pa_temp],[pa_bmi],[age],[date_added],[dg_id],[added_by],[added_for],[record_date],[pa_oxm], [pa_bp_location], [pa_bp_sys_statnding], [pa_bp_dys_statnding], [pa_bp_location_statnding], [pa_bp_sys_supine], [pa_bp_dys_supine], [pa_bp_location_supine], [pa_temp_method], [pa_pulse_rhythm], [pa_pulse_standing], [pa_pulse_rhythm_standing], [pa_pulse_supine], [pa_pulse_rhythm_supine], [pa_heart_rate], [pa_fio2], [pa_flow], [pa_resp_quality],[pa_comment]  
	FROM [dbo].[patient_vitals]  
	WHERE [pa_vt_id] = @VitalsId AND PA_ID = @PatientId 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
