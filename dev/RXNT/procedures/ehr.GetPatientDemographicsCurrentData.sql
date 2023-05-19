SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:  JahabarYusuff M 
-- Create date: 09-Jul-2020 
-- Description: Get patient current demographics info 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[GetPatientDemographicsCurrentData]
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
		  p.pa_race_type ,
              p.pa_ethn_type,
               p.pref_lang,
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
        ped.pa_sexual_orientation, 
        ped.empl_status, 
        ped.comm_pref, 
        ped.pref_phone, 
        ped.time_zone, 
        ped.pa_gender_identity, 
        ped.emergency_contact_first, 
        ped.emergency_contact_last, 
		ped.emergency_contact_last+', '+ped.emergency_contact_first   AS emergency_name,      
        ped.emergency_contact_phone, 
        ped.emergency_contact_relationship
    FROM patients p WITH(NOLOCK)
    LEFT OUTER JOIN patient_extended_details ped  WITH(NOLOCK) ON p.pa_id = ped.pa_id
    LEFT OUTER JOIN doctors prim_doc WITH(NOLOCK) ON ped.prim_dr_id=prim_doc.dr_id AND prim_doc.prescribing_authority >= 3
    WHERE p.pa_id = @PatientId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
