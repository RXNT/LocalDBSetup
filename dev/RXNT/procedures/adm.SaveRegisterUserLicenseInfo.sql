SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 17-APR-2018
-- Description:	Save Register User License Info
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [adm].[SaveRegisterUserLicenseInfo]
	@V2DoctorCompanyId					BIGINT=0,
	@LoginId							BIGINT=0,
	@NextBillingDate					DATETIME=NULL
AS
BEGIN
	DECLARE @DoctorId AS BIGINT = 0
	IF(ISNULL(@V2DoctorCompanyId,0) > 0 AND ISNULL(@LoginId,0) > 0)
	BEGIN
		SELECT TOP 1 @DoctorId=ISNULL(ExternalLoginId,0) FROM [dbo].[RsynRxNTMasterLoginExternalAppMaps] WITH(NOLOCK) WHERE LoginId=@LoginId AND ExternalAppId=1
		IF(ISNULL(@DoctorId,0) > 0)
		BEGIN
			UPDATE D SET D.loginlock=0, D.billingDate=NULL,D.billing_enabled=0
			FROM doctors D WITH(NOLOCK)
			INNER JOIN doc_groups DG WITH(NOLOCK) ON D.dg_id=DG.dg_id
			INNER JOIN [dbo].[RsynMasterCompanies] EDC WITH(NOLOCK) ON EDC.CompanyId=@V2DoctorCompanyId
			INNER JOIN [dbo].[RsynMasterCompanyExternalAppMaps] EDCMAP WITH(NOLOCK) ON EDC.CompanyId=EDCMAP.CompanyId
			INNER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id=EDCMAP.ExternalCompanyId AND DC.dc_id=EDCMAP.ExternalCompanyId
			WHERE D.DR_ENABLED = 1 AND  EDC.CompanyId=@V2DoctorCompanyId AND D.dr_id=@DoctorId
		END
		
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
