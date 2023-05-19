SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_GetUserDetails] 
@UserId BIGINT,
@DoctorCompanyId BIGINT 
AS
BEGIN 
	SELECT D.DR_FIRST_NAME FirstName, D.DR_PREFIX Prefix
	,loginlock LoginLock
	,dr_enabled IsEnabled
	,dr_lic_numb LicenseNumber
	,D.DR_SUFFIX Suffix
	,D.epcs_enabled IsEPCSEnabled
	, D.hipaa_agreement_acptd IsHipaaAgreementAccepted
	, D.dr_agreement_acptd IsRxntLicenseAccepted
	, D.dr_def_rxcard_history_back_to RxcardLookupPeriod
	,D.dr_rxcard_search_consent_type RxCardConsentType
	,D.dr_def_pat_history_back_to PatientHistoryLookupPeriod
	,D.NPI
	,D.TIME_DIFFERENCE TimeDifference
	,D.DR_MIDDLE_INITIAL MiddleName
	,D.DR_LAST_NAME LastName
	,D.DR_USERNAME UserName
	,D.DR_ID DoctorId
	,DG.DG_NAME DoctorGroupName
	,D.DG_ID DoctorGroupId
	,DG.DC_ID DoctorCompanyId
	,D.DR_ADDRESS1 Address1
	,D.DR_ADDRESS2 Address2
	,D.DR_CITY City, 
	D.DR_STATE State
	,D.DR_DEA_NUMB DeaNumber
	,D.DR_ZIP ZipCode, D.DR_PHONE Phone,D.DR_EMAIL Email
	, D.RIGHTS RightsMask, D.DR_FAX Fax
	,PRESCRIBING_AUTHORITY PrescribingAuthority, ISNULL(DI.EnableRulesEngine, 0) As EnableRulesEngine
	,D.professional_designation EnableRulesEngine
	,DC.dc_name DoctorCompanyName
	FROM DOCTORS D WITH(NOLOCK)
	INNER JOIN DOC_GROUPS DG ON D.DG_ID = DG.DG_ID 
	INNER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id=DC.dc_id 
	LEFT JOIN doctor_info DI WITH (NOLOCK) ON DI.dr_id = D.dr_id 
	WHERE D.DR_ID = @UserId AND dg.dc_id=@DoctorCompanyId
                 
                                   
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
