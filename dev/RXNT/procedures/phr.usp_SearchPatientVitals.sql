SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SearchPatientVitals]
	@PatientId			INT,
	@DoctorCompanyId	INT
AS
BEGIN

	SELECT	[age] as age, 
			CONVERT(VARCHAR(20),[date_added],101) as entryDate, 
			CONVERT(VARCHAR(20),[record_date],101) as recordDate, 
			ISNULL(addedby.DR_LAST_NAME,'') + ' '  + ISNULL(addedby.DR_FIRST_NAME,'')  as addedBy,
			CASE WHEN pv.[pa_ht] > 0 THEN CAST(CAST(ROUND (pv.[pa_ht]* 0.393700787 , 2) AS DECIMAL(10,2)) AS VARCHAR(50))+' in' ELSE NULL END as heightInches, 
			CASE WHEN [pa_wt] > 0 THEN CAST(CAST(ROUND ([pa_wt]* 2.20462262, 2) AS DECIMAL(10,2)) AS VARCHAR(50))+' lbs' ELSE NULL END as weightLbs, 			
			CASE WHEN [pa_hc] > 0 THEN CAST(CAST(ROUND ([pa_hc] * 0.393700787 , 2) AS DECIMAL(10,2))AS VARCHAR(50))+' in' ELSE NULL END as headCircInches,
			CASE WHEN pv.[pa_ht] > 0 THEN CAST(CAST(ROUND (pv.[pa_ht], 2) AS DECIMAL(10,2))AS VARCHAR(50))+' cms' ELSE NULL END as heightCentimeters, 
			CASE WHEN [pa_wt] > 0 THEN CAST(CAST(ROUND ([pa_wt], 2) AS DECIMAL(10,2))AS VARCHAR(50))+' kgs' ELSE NULL END as weightKiloGrams, 			
			CASE WHEN [pa_hc] > 0 THEN CAST(CAST(ROUND ([pa_hc], 2) AS DECIMAL(10,2))AS VARCHAR(50))+' cms' ELSE NULL END as headCircCentimeters,
			CAST(ROUND ([pa_bmi], 2) AS DECIMAL(10,2)) as bmi, 
			CASE WHEN [pa_temp] > 0 THEN CAST(CAST(ROUND ([pa_temp], 2) AS DECIMAL(10,2)) AS VARCHAR(50))+' F' ELSE NULL END as temperature,
			CASE WHEN [pa_resp_rate] > 0 THEN CAST([pa_resp_rate] as varchar)+' breaths/min' ELSE NULL END as respiration, 
			CASE WHEN [pa_glucose] > 0 THEN CAST([pa_glucose] as varchar)+' mg/DL' ELSE NULL END as glucose,				
			CASE WHEN [pa_bp_sys] > 0 AND [pa_bp_dys] > 0 THEN CAST(pa_bp_sys as varchar)+ '/' + CAST(pa_bp_dys as varchar)+ ' mm/Hg' ELSE NULL END as sittingBp,
			CASE WHEN [pa_bp_sys_statnding] > 0 AND [pa_bp_dys_statnding] > 0 THEN CAST(pa_bp_sys_statnding as varchar)+ '/' + CAST(pa_bp_dys_statnding as varchar)+ ' mm/Hg' ELSE NULL END as standingBp,
			CASE WHEN [pa_bp_sys_supine] > 0 AND pa_bp_dys_supine>0 THEN CAST(pa_bp_sys_supine as varchar)+ '/' + CAST(pa_bp_dys_supine as varchar)+ ' mm/Hg' ELSE NULL END as supineBp,			
			CASE pa_bp_location WHEN 1 THEN 'Right Upper Arm' WHEN 2 THEN 'Right Thigh' WHEN 3 THEN 'Right Hand' 
			WHEN 4 THEN 'Right Arm' WHEN 5 THEN 'Left Upper Arm' WHEN 6 THEN 'Left Thigh' WHEN 7 THEN 'Left Hand' 
			WHEN 8 THEN 'Left Arm' WHEN 9 THEN 'Other' END as sittingLocation, 
			CASE pa_bp_location_statnding WHEN 1 THEN 'Right Upper Arm' WHEN 2 THEN 'Right Thigh' WHEN 3 THEN 'Right Hand' 
			WHEN 4 THEN 'Right Arm' WHEN 5 THEN 'Left Upper Arm' WHEN 6 THEN 'Left Thigh' WHEN 7 THEN 'Left Hand' 
			WHEN 8 THEN 'Left Arm' WHEN 9 THEN 'Other' END as standingLocation, 
			CASE pa_bp_location_supine WHEN 1 THEN 'Right Upper Arm' WHEN 2 THEN 'Right Thigh' WHEN 3 THEN 'Right Hand' 
			WHEN 4 THEN 'Right Arm' WHEN 5 THEN 'Left Upper Arm' WHEN 6 THEN 'Left Thigh' WHEN 7 THEN 'Left Hand' 
			WHEN 8 THEN 'Left Arm' WHEN 9 THEN 'Other' END as supineLocation,			
			CASE WHEN [pa_pulse] > 0 THEN CAST(pa_pulse as varchar)+' beats/min' ELSE NULL END as sittingPulse,
			CASE WHEN [pa_pulse_standing] > 0 THEN CAST (pa_pulse_standing as varchar)+' beats/min' ELSE NULL END  as standingPulse, 
			CASE WHEN [pa_pulse_supine] > 0 THEN CAST (pa_pulse_supine as varchar)+' beats/min' ELSE NULL END as supinePulse,
			CASE [pa_pulse_rhythm] WHEN 1 THEN 'Regular' WHEN 2 THEN 'Irregular' END as sittingRhythm, 
			CASE [pa_pulse_rhythm_standing] WHEN 1 THEN 'Regular' WHEN 2 THEN 'Irregular' END as standingRhythm, 
			CASE [pa_pulse_rhythm_supine] WHEN 1 THEN 'Regular' WHEN 2 THEN 'Irregular' END as supineRhythm,
			CASE WHEN [pa_resp_rate] > 0 THEN CAST(pa_heart_rate as varchar)+' beats/Min' ELSE NULL END as heartRate,
			CASE WHEN [pa_oxm] > 0 THEN CAST(pa_oxm as varchar)+' %' ELSE NULL END as oxygenSaturation,
			CASE WHEN [pa_fio2] > 0 THEN CAST(pa_fio2 as varchar)+' %' ELSE NULL END as fio2,
			CASE WHEN [pa_flow] > 0 THEN CAST(pa_flow as varchar)+' Litres/Min' ELSE NULL END as flow,
			ISNULL(pa_comment,'') as comments	
			FROM [dbo].[patient_vitals] pv WITH(NOLOCK)
			INNER JOIN patients p WITH(NOLOCK) ON p.pa_id = pv.pa_id
			LEFT OUTER JOIN doctors addedby WITH(NOLOCK) ON addedby.dr_id = pv.added_by		
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = p.dg_id 
			WHERE dg.dc_id = @DoctorCompanyId AND pv.pa_id=@PatientId
			
END			
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
