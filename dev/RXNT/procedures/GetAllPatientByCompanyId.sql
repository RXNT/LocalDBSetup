SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Niyaz
Create date			: 10th-Sep-2018
Description			: 
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [dbo].[GetAllPatientByCompanyId] 
	@DoctorCompanyId BIGINT
AS 
BEGIN 	
	DECLARE @V2CompanyId  BIGINT 

	SELECT @V2CompanyId = CompanyId 
	FROM [dbo].[RsynMasterCompanyExternalAppMaps] WITH(NOLOCK)
	WHERE ExternalCompanyId = @DoctorCompanyId AND ExternalAppId = 1

	SELECT 
		pat.pa_id AS PatientId,
		MP.PatientId AS MRNId,
		pat.dg_id AS DoctorGroupId,
		pat.dr_id AS DoctorId,
		pat.pa_first AS PatientFirstName,
		pat.pa_last AS PatientLastName,
		pat.pa_middle AS PatientMiddleName,
		pat.pa_dob AS DOB,
		pat.pa_ssn AS PatientSSN,
		pat.pa_address1 AS PatientAddress1,
		pat.pa_address2 AS PatientAddress2,
		pat.pa_city AS PatientCity,
		pat.pa_zip AS PatientZip,
		pat.pa_phone AS PatientPhone,
		pat.pa_email AS PatientEmail,
		stt.state AS PatientState,
		Gender =
		CASE pat.pa_sex
			WHEN 'F' THEN 'Female'
			WHEN 'M' THEN 'Male'
			WHEN 'U' THEN 'Unknown'
			ELSE ''
		END, 
		dr_pref.dr_prefix PrefProviderPrefix, 
		dr_pref.dr_first_name PrefProviderFirstName, 
		dr_pref.dr_middle_initial PrefProviderMiddleName, 
		dr_pref.dr_last_name PrefProviderLastName, 
		dr_pref.dr_suffix PrefProviderSuffix
	FROM patients pat WITH(NOLOCK)
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN doc_companies dc WITH(NOLOCK) ON dc.dc_id=dg.dc_id
	LEFT OUTER JOIN patient_extended_details patex WITH(NOLOCK) ON patex.pa_id=pat.pa_id
	LEFT OUTER JOIN doctors dr_pref WITH(NOLOCK) ON dr_pref.dr_id=patex.prim_dr_id
	LEFT JOIN State stt WITH(NOLOCK) ON stt.state_code=pat.pa_state
	LEFT OUTER JOIN [dbo].[RsynMasterPatientExternalAppMaps] MPE WITH(NOLOCK) ON MPE.CompanyId=@V2CompanyId AND MPE.ExternalPatientId=pat.pa_id and ExternalDoctorCompanyId = @DoctorCompanyId AND ExternalAppId = 1
	LEFT OUTER JOIN  [dbo].[RsynMasterPatients] MP WITH(NOLOCK) ON MPE.PatientId=MP.PatientId AND MP.CompanyId = @V2CompanyId
	WHERE dc.dc_id=@DoctorCompanyId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
