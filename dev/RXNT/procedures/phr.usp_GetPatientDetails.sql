SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		:	Nambi
-- Create date	:	15-OCT-2018
-- Description	:	Get Patient Details
-- Modified By  : Jahabar Yusuff M
-- Modified date:	30-MAR-2020
-- Description	:	return DOB field with converstion(MM/DD/YYYY)

-- =============================================

CREATE PROCEDURE [phr].[usp_GetPatientDetails]
	@PatientId			INT,
	@DoctorCompanyId	INT
AS
BEGIN
	SELECT	
			p.pa_last + ', ' + p.pa_first + ' ' + ISNULL(p.pa_middle, '') AS name,
			p.pa_last AS lastName,
			p.pa_first AS firstName,
			ISNULL(p.pa_middle, '') AS middleName,
			ISNULL(ped.pa_nick_name,'') AS nickName,
			--p.pa_dob AS dob,
			CONVERT(varchar, p.pa_dob, 101) dob,
			ISNULL(p.pa_email,'') AS email,
			ISNULL(p.pa_address1,'') AS addressOne,
			ISNULL(p.pa_address2,'') AS addressTwo,
			ISNULL(p.pa_city,'') AS city,
			ISNULL(p.pa_state,'') AS state, 
			ISNULL(p.pa_zip,'') AS zip,
			ISNULL(ped.pref_phone,0) AS preferredPhone,
			ISNULL(p.pa_phone,'') AS homePhone,
			ISNULL(ped.cell_phone,'') AS cellPhone,
			ISNULL(ped.work_phone,'') AS workPhone,
			ISNULL(ped.other_phone,'') AS otherPhone,
			ISNULL(p.pa_sex,'') AS sex,
			ISNULL(ped.pa_sexual_orientation,0) AS sexualOrientation,
			ISNULL(ped.pa_sexual_orientation_detail,'') AS sexualOrientationDetail,
			ISNULL(ped.pa_gender_identity,0) AS genderIdentity,
			ISNULL(ped.pa_gender_identity_detail,'') AS genderIdentityDetail,
			ISNULL(p.pa_race_type,0) AS raceCategory,
			ISNULL(p.pa_ethn_type,0) AS ethnicity,
			ISNULL(ped.marital_status,0) AS maritalStatus,
			ISNULL(ped.empl_status,0) AS employmentStatus,
			ISNULL(ped.comm_pref,0) AS communicationPreference,
			ISNULL(MP.HasCompleteProfile,1) AS hasCompleteProfile,
            ISNULL(ped.pa_previous_name, '') as previousName,
            ISNULL(p.pa_suffix, '') as suffix,
            ISNULL(p.pref_lang, 0) as preferredLanguageId
			FROM patients p WITH(NOLOCK)
			LEFT OUTER JOIN patient_extended_details ped WITH(NOLOCK) ON p.pa_id = ped.pa_id
			LEFT OUTER JOIN [dbo].[RsynMasterPatientExternalAppMaps] MPE WITH(NOLOCK) ON MPE.ExternalPatientId=CAST(p.pa_id AS VARCHAR)
			LEFT OUTER JOIN [dbo].[RsynMasterPatients] MP WITH(NOLOCK) ON MPE.PatientId=MP.PatientId			
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = p.dg_id
			WHERE dg.dc_id = @DoctorCompanyId AND p.pa_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
