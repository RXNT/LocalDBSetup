SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 01-May-2019
-- Description:	Get v2 user details
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[GetV2LoginInfo]
	@DoctorCompanyId BIGINT,
	@UserId BIGINT
AS
BEGIN
	 SELECT L.LoginId,CMP.CompanyId,L.IsBillingContact,L.IsPrimaryBillingContact,L.LicensingProfileId,CMP.BillingProfileExternalId BillingProfileExternalId 
	 FROM dbo.RsynRxNTMasterLogins L WITH(NOLOCK)
	 INNER JOIN dbo.RsynRxNTMasterLoginExternalAppMaps LEM WITH(NOLOCK) ON L.LoginId=LEM.LoginId AND LEM.ExternalAppId=1
	 INNER JOIN dbo.RsynRxNTMasterCompaniesTable CMP WITH(NOLOCK) ON LEM.CompanyId = CMP.CompanyId
	 WHERE LEM.ExternalLoginId=@UserId AND LEM.ExternalCompanyId = @DoctorCompanyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
