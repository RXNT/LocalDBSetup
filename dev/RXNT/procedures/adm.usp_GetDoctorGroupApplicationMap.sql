SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 23-Mar-2015
-- Description:	To enable application bridge on EHR
-- Modified By: Jagadeesh
-- Modified Date: 02-APR-2015
-- =============================================
CREATE PROCEDURE [adm].[usp_GetDoctorGroupApplicationMap]
	@CompanyId BIGINT,
	@GroupId BIGINT = 0,
	@EnablePMV2Bridge BIT OUTPUT,
	@EnableSchedulerV2Bridge BIT OUTPUT,
	@EnableV2Dashboard BIT = NULL OUTPUT, 	--Added by Nambi for RS-4920 & RS-4923
	@EnableV2EncounterTemplate BIT = NULL OUTPUT,	--Added by Rajaram for TemplateEngine Project
	@EnableRulesEngine BIT = NULL OUTPUT,	--Added by Vidya for Rules Engine
	@LowUsageFlag TINYINT = 0 OUTPUT
AS

BEGIN
	SET NOCOUNT ON;
	DECLARE @PMV2AppId_EHR BIGINT,
			@SchedulerV2AppId_EHR BIGINT
	SET @EnableV2EncounterTemplate = 0
	
	SELECT @PMV2AppId_EHR = App.ApplicationId  
	FROM [Applications] App
	INNER JOIN [ApplicationTypes] AppType ON App.ApplicationTypeID = AppType.ApplicationTypeID 
	INNER JOIN [ApplicationVersions] AppVer ON App.ApplicationVersionID = AppVer.ApplicationVersionID 
	WHERE AppType.ApplicationTypeName = 'PM' AND 
		AppVer.ApplicationVersion = 'Version2'
		
	SELECT @SchedulerV2AppId_EHR = App.ApplicationId  
	FROM [Applications] App
	INNER JOIN [ApplicationTypes] AppType ON App.ApplicationTypeID = AppType.ApplicationTypeID 
	INNER JOIN [ApplicationVersions] AppVer ON App.ApplicationVersionID = AppVer.ApplicationVersionID 
	WHERE AppType.ApplicationTypeName = 'Scheduler' AND 
		AppVer.ApplicationVersion = 'Version2'
	
	--Check PMV2 Bridge
	IF EXISTS(SELECT TOP 1 1 
			FROM  doc_group_application_map DGM 
			INNER JOIN doc_groups DG ON DG.dg_id = DGM.dg_id
			INNER JOIN doc_companies DC ON DG.dc_id = DC.dc_id
			WHERE DC.dc_id = @CompanyId AND
			(DG.dg_id = @GroupId OR ISNULL(@GroupId,0)=0) AND
			DGM.ApplicationID = @PMV2AppId_EHR)
	BEGIN
		SET @EnablePMV2Bridge = 1
	END

	--Check SchedulerV2 Bridge
	IF EXISTS(SELECT TOP 1 1 
			FROM  doc_group_application_map DGM 
			INNER JOIN doc_groups DG ON DG.dg_id = DGM.dg_id
			INNER JOIN doc_companies DC ON DG.dc_id = DC.dc_id
			WHERE DC.dc_id = @CompanyId AND
			(DG.dg_id = @GroupId OR ISNULL(@GroupId,0)=0) AND
			DGM.ApplicationID = @SchedulerV2AppId_EHR)
	BEGIN
		SET @EnableSchedulerV2Bridge = 1
	END
	--Added by Nambi for RS-4920 & RS-4923
	SELECT @EnableV2Dashboard = is_custom_tester from doc_companies where dc_id=@CompanyId
	--Added by Nambi for RS-4920 & RS-4923 Ends

	--Added by Rajaram for TemplateEngine Project Start

	SELECT  @EnableV2EncounterTemplate = EnableV2EncounterTemplate
	FROM	doc_companies doc_cmp WITH(NOLOCK)
	WHERE	doc_cmp.dc_id = @CompanyId

	--Added by Rajaram for TemplateEngine Project End

	--Added by Vidya for Rules Engine Start
	DECLARE @IsEnableRulesEngine BIT

	SELECT  @IsEnableRulesEngine = EnableRulesEngine
	FROM	doc_companies doc_cmp WITH(NOLOCK)
	WHERE	doc_cmp.dc_id = @CompanyId

	IF @IsEnableRulesEngine IS NOT NULL
	BEGIN
		SET @EnableRulesEngine = @IsEnableRulesEngine
	END
	--Added by Vidya for Rules Engine End
	
	SELECT TOP 1 @LowUsageFlag=ISNULL(UsageFlags,0)
	FROM [dbo].[DoctorGroupUsageFlags] WITH(NOLOCK)
	WHERE DoctorGroupId=@GroupId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
