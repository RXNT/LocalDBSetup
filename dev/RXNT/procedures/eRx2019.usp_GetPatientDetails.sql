SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_GetPatientDetails] 
@PatientId BIGINT,
@DoctorCompanyId BIGINT 
AS
BEGIN 
	SELECT p.pa_id PatientId ,p.pa_first FirstName, p.pa_prefix Prefix
	,p.pa_suffix Suffix
	,p.pa_middle MiddleName
	,p.pa_last LastName
	,p.pa_sex Gender
	,P.pa_id DoctorId
	,DG.DG_NAME DoctorGroupName
	,p.DG_ID DoctorGroupId
	,DG.DC_ID DoctorCompanyId
	,p.pa_address1 Address1
	,p.pa_ADDRESS2 Address2
	,p.pa_CITY City, 
	p.pa_STATE State
	,p.pa_ZIP ZipCode, p.pa_PHONE Phone,p.pa_EMAIL Email
	,DC.dc_name DoctorCompanyName
	,p.pa_dob PatientDOB
	FROM patients p WITH(NOLOCK)
	INNER JOIN doc_groups DG ON p.DG_ID = DG.DG_ID 
	INNER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id=DC.dc_id 
	WHERE p.pa_id = @PatientId AND dg.dc_id=@DoctorCompanyId
                 
                                   
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
