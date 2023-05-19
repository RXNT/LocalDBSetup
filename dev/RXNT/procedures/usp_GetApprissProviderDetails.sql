SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
 
-- =============================================  
-- Author:    
-- Create date: 09-April-2020
-- Description: Get Appriss Provider Details
-- =============================================  

CREATE PROCEDURE [dbo].[usp_GetApprissProviderDetails]
 @ProviderId BIGINT,
 @DoctorGroupId BIGINT
AS  
BEGIN  
	SELECT PR.[Name] 'ProviderRole',
				V1DC.[dr_dea_numb],
               GRP.[GroupNPI],
			   dg.[dg_name],
                GAD.[Address1],
                GAD.[Address2],
                ZC.[City],
                ST.[Name] 'StateName',
                ST.[Code] 'StateCode',
                GAD.[ZipCode],
                GAD.[ZipExtension],
                GEI.[ApprissText1] 'UserName',
                GEI.[ApprissText2] 'Password',
                GEI.[ApprissText3] 'PasswordSalt',
				'SLN' ProfessionalLicenseNumberType,
				V1DC.dr_lic_numb ProfessionalLicenseNumber,
				V1DC.dr_lic_state ProfessionalLicenseNumberStateCode
			FROM dbo.doctors V1DC WITH(NOLOCK)
			INNER JOIN dbo.doc_groups dg WITH(NOLOCK) ON V1DC.dg_id=dg.dg_id
            INNER JOIN dbo.RsynRxNTMasterLoginExternalAppMaps LEA WITH(NOLOCK) ON V1DC.dr_id = LEA.ExternalLoginId AND dg.dc_id=LEA.ExternalCompanyId AND LEA.ExternalAppId=1
            INNER JOIN dbo.RsynRxNTMasterLogins LG WITH(NOLOCK) ON LG.LoginId = LEA.LoginId
            INNER JOIN dbo.RsynRxNTMasterLicensingProfiles LP WITH(NOLOCK) ON LP.LicensingProfileId = LG.LicensingProfileId
            INNER JOIN dbo.RsynMasterGroupExternalAppMaps GEA WITH(NOLOCK) ON GEA.ExternalGroupId = V1DC.dg_id
            INNER JOIN dbo.RsynMasterGroups GRP WITH(NOLOCK) ON GRP.GroupId = GEA.GroupId
            LEFT JOIN  dbo.RsynMasterGroupAddresses GAD WITH(NOLOCK) ON GAD.GroupId = GEA.GroupId AND GAD.DefaultAddress = 1 AND GAD.Active = 1
            LEFT JOIN  dbo.RsynMasterGroupExtendedInfo GEI WITH(NOLOCK) ON GEI.GroupId = GEA.GroupId
            LEFT JOIN  dbo.RsynMasterZipCodes ZC WITH(NOLOCK) ON ZC.ZipCodeId = GAD.[CityId]
            LEFT JOIN  dbo.RsynMasterStates ST WITH(NOLOCK) ON ST.StateId = GAD.[StateId]
            LEFT JOIN  dbo.RsynMasterProviderRoles PR WITH(NOLOCK) ON PR.ProviderRoleId = LP.ProviderRoleId
            WHERE V1DC.dr_id=@ProviderId AND dg.dg_id=@DoctorGroupId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
