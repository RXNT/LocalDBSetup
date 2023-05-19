SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To get the patient information
-- Modified By: JahabarYusuff M
-- Modified Date: added new column to get the status of sync review status -is_patient_intake_sync_review_pending
-- =============================================
CREATE   PROCEDURE [ehr].[usp_GetPatient]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	 SELECT p.pa_id,
        p.pa_last+', '+p.pa_first+ CASE WHEN LEN(p.pa_middle)>0 THEN  ' '+p.pa_middle+'.'  ELSE '' END AS pa_name,
        p.pa_last,
		p.pa_first,
		p.pa_middle,
        p.pa_sex,
        p.pa_address1,
        p.pa_address2,
        p.pa_city,
        p.pa_state,
        p.pa_zip,
        p.pa_dob,
        p.pa_phone,
		p.pa_email,
        p.pa_ssn AS pa_chart,
		p.pa_ext_ssn_no,
		p.pa_suffix,
		vrc.Description AS race,
		pl.Name AS preferred_language,
		vec.Description AS ethnicity,
		CASE 
			WHEN p.pa_sex = 'M' THEN 'Male'
			WHEN p.pa_sex = 'F' THEN 'Female'
			ELSE 'Unknown'
		END AS birthsex,
		ped.pa_previous_name,
		ped.pa_nick_name, 
        ped.pa_ext_ref, 
        ped.pa_ref_name_details,
        ped.pa_ref_date,
        prim_doc.dr_id AS prim_dr_id,
        ped.dr_id, 
        ped.cell_phone,
        ped.work_phone,
        ped.other_phone, 
        ped.marital_status, 
        ped.pa_death_date, 
        ped.empl_status, 
        ped.comm_pref, 
        ped.pref_phone, 
        ped.time_zone, 
        ped.pref_start_time, 
        ped.pref_end_time, 
        ped.mother_first, 
        ped.mother_middle, 
        ped.mother_last, 
        ped.emergency_contact_first, 
        ped.emergency_contact_last, 
        ped.emergency_contact_address1, 
        ped.emergency_contact_address2, 
        ped.emergency_contact_city, 
        ped.emergency_contact_state, 
        ped.emergency_contact_zip, 
        ped.emergency_contact_phone, 
        ped.emergency_contact_relationship, 
        ped.emergency_contact_release_documents,
		ped.is_patient_intake_sync_review_pending
    FROM patients p WITH(NOLOCK)
    LEFT OUTER JOIN patient_extended_details ped  WITH(NOLOCK) ON p.pa_id = ped.pa_id
    LEFT OUTER JOIN doctors prim_doc WITH(NOLOCK) ON ped.prim_dr_id=prim_doc.dr_id AND prim_doc.prescribing_authority >= 3
	LEFT OUTER JOIN [RxNT].[cqm2019].[vwRaceCodes] vrc WITH(NOLOCK) ON p.pa_race_type = vrc.RaceId
	LEFT OUTER JOIN [RxNT].[cqm2019].[vwEthnicityCodes] vec WITH(NOLOCK) ON p.pa_ethn_type = vec.EthnicityId
	LEFT OUTER JOIN [RxNT].[dbo].[PreferredLanguages] pl WITH(NOLOCK) ON p.pref_lang = pl.PreferredLanguageId
    WHERE p.pa_id = @PatientId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
