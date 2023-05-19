SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Vinod
Create date			: 02-Feb-2020
Description			: Remove EHR/ERx Module of a company
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [adm].[DeactivateV1ApplicationForCompany] 
	@CompanyId BIGINT   ,
	@RemoveERxModule   BIT=0,
	@RemoveEHRModule   BIT=0
	
	
AS

IF @RemoveEHRModule=1
BEGIN
	DECLARE @EHRAppId BIGINT
	SELECT @EHRAppId=ApplicationId FROM dbo.RsynMasterApplications WITH(NOLOCK) WHERE Code='EHRAP'
	
	 
	WHILE EXISTS(SELECT PM.* FROM [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH(NOLOCK)
	INNER JOIN doc_companies DC WITH(NOLOCK) ON CEAM.ExternalCompanyId=DC.dc_id
	INNER JOIN patient_menu PM WITH(NOLOCK) ON PM.dc_id=DC.dc_id
	INNER JOIN master_patient_menu mpm  WITH(NOLOCK) ON PM.master_patient_menu_id = mpm.master_patient_menu_id
	WHERE CompanyId=@CompanyId AND ExternalAppId=@EHRAppId AND mpm.is_erx!=1 )
	BEGIN
		DELETE PM FROM [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH(NOLOCK)
		INNER JOIN doc_companies DC WITH(NOLOCK) ON CEAM.ExternalCompanyId=DC.dc_id
		INNER JOIN patient_menu PM WITH(NOLOCK) ON PM.dc_id=DC.dc_id
		INNER JOIN master_patient_menu mpm  WITH(NOLOCK) ON PM.master_patient_menu_id = mpm.master_patient_menu_id
		WHERE CompanyId=@CompanyId AND ExternalAppId=@EHRAppId AND mpm.is_erx!=1 

	END
	 

	WHILE EXISTS(SELECT PM.* FROM [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH(NOLOCK)
	INNER JOIN doc_companies DC WITH(NOLOCK) ON CEAM.ExternalCompanyId=DC.dc_id
	INNER JOIN patient_menu_doctor_level PM WITH(NOLOCK) ON PM.dc_id=DC.dc_id
	INNER JOIN master_patient_menu mpm  WITH(NOLOCK) ON PM.master_patient_menu_id = mpm.master_patient_menu_id
	WHERE CompanyId=@CompanyId AND ExternalAppId=@EHRAppId AND mpm.is_erx!=1 )
	BEGIN
		DELETE PM FROM [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH(NOLOCK)
		INNER JOIN doc_companies DC WITH(NOLOCK) ON CEAM.ExternalCompanyId=DC.dc_id
		INNER JOIN patient_menu_doctor_level PM WITH(NOLOCK) ON PM.dc_id=DC.dc_id
		INNER JOIN master_patient_menu mpm  WITH(NOLOCK) ON PM.master_patient_menu_id = mpm.master_patient_menu_id
		WHERE CompanyId=@CompanyId AND ExternalAppId=@EHRAppId AND mpm.is_erx!=1 
		

	END
 END
 IF @RemoveERxModule =1
 BEGIN
	DECLARE @ERxAppId BIGINT
	SELECT @ERxAppId=ApplicationId FROM dbo.RsynMasterApplications WITH(NOLOCK) WHERE Code='ERXV1'
	
 
	WHILE EXISTS(SELECT PM.* FROM [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH(NOLOCK)
	INNER JOIN doc_companies DC WITH(NOLOCK) ON CEAM.ExternalCompanyId=DC.dc_id
	INNER JOIN patient_menu PM WITH(NOLOCK) ON PM.dc_id=DC.dc_id
	INNER JOIN master_patient_menu mpm  WITH(NOLOCK) ON PM.master_patient_menu_id = mpm.master_patient_menu_id
	WHERE CompanyId=@CompanyId AND ExternalAppId=@ERxAppId AND mpm.is_erx=1 )
	BEGIN
		DELETE PM FROM [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH(NOLOCK)
		INNER JOIN doc_companies DC WITH(NOLOCK) ON CEAM.ExternalCompanyId=DC.dc_id
		INNER JOIN patient_menu PM WITH(NOLOCK) ON PM.dc_id=DC.dc_id
		INNER JOIN master_patient_menu mpm  WITH(NOLOCK) ON PM.master_patient_menu_id = mpm.master_patient_menu_id
		WHERE CompanyId=@CompanyId AND ExternalAppId=@ERxAppId AND mpm.is_erx=1 

	END
	 

	WHILE EXISTS(SELECT PM.* FROM [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH(NOLOCK)
	INNER JOIN doc_companies DC WITH(NOLOCK) ON CEAM.ExternalCompanyId=DC.dc_id
	INNER JOIN patient_menu_doctor_level PM WITH(NOLOCK) ON PM.dc_id=DC.dc_id
	INNER JOIN master_patient_menu mpm  WITH(NOLOCK) ON PM.master_patient_menu_id = mpm.master_patient_menu_id
	WHERE CompanyId=@CompanyId AND ExternalAppId=@ERxAppId AND mpm.is_erx=1 )
	BEGIN
		DELETE PM FROM [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH(NOLOCK)
		INNER JOIN doc_companies DC WITH(NOLOCK) ON CEAM.ExternalCompanyId=DC.dc_id
		INNER JOIN patient_menu_doctor_level PM WITH(NOLOCK) ON PM.dc_id=DC.dc_id
		INNER JOIN master_patient_menu mpm  WITH(NOLOCK) ON PM.master_patient_menu_id = mpm.master_patient_menu_id
		WHERE CompanyId=@CompanyId AND ExternalAppId=@ERxAppId AND mpm.is_erx=1 
	END
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
