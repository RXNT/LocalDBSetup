SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 23-Mar-2015
-- Description:	To enable application bridge on EHR
-- Modified By: Jagadeesh
-- Modified Date: 31-MAR-2015
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveDoctorGroupApplicationMap]
	@CompanyId BIGINT,
	@GroupId BIGINT = 0,
	@EnablePMV2Bridge BIT,
	@EnableSchedulerV2Bridge BIT
AS

BEGIN
	SET NOCOUNT ON;
	DECLARE @PMV2AppId_EHR BIGINT,
			@SchedulerV2AppId_EHR BIGINT
			
	
	SELECT @PMV2AppId_EHR = App.ApplicationId  
	FROM [Applications] App
	INNER JOIN [ApplicationTypes] AppType ON App.ApplicationTypeID = AppType.ApplicationTypeID 
	INNER JOIN [ApplicationVersions] AppVer ON App.ApplicationVersionID = AppVer.ApplicationVersionID 
	WHERE AppType.ApplicationTypeName = 'PM' AND 
		AppVer.ApplicationVersion = 'Version2'
	
	--SELECT @PMV2AppId_EHR = App.ApplicationId
	--FROM [rxn].[Applications] APP
	--WHERE APP.CODE = 'PMV2B'
		
	SELECT @SchedulerV2AppId_EHR = App.ApplicationId  
	FROM [Applications] App
	INNER JOIN [ApplicationTypes] AppType ON App.ApplicationTypeID = AppType.ApplicationTypeID 
	INNER JOIN [ApplicationVersions] AppVer ON App.ApplicationVersionID = AppVer.ApplicationVersionID 
	WHERE AppType.ApplicationTypeName = 'Scheduler' AND 
		AppVer.ApplicationVersion = 'Version2'
	
	--SELECT @SchedulerV2AppId_EHR = App.ApplicationId
	--FROM [rxn].[Applications] APP
	--WHERE APP.CODE = 'SCHV2'
	
	-- PMV2 Bridge Start
	IF @EnablePMV2Bridge = 1
	BEGIN
		INSERT INTO doc_group_application_map (
			dg_id, ApplicationID
		)
		SELECT DG.dg_id,@PMV2AppId_EHR 
		FROM doc_groups DG 
			INNER JOIN doc_companies DC ON DG.dc_id = DC.dc_id
		WHERE DC.dc_id = @CompanyId AND
			(DG.dg_id = @GroupId OR ISNULL(@GroupId,0) = 0) AND
			NOT EXISTS (SELECT 1 FROM doc_group_application_map DGAM 
						WHERE DGAM.dg_id = DG.dg_id AND DGAM.ApplicationID = @PMV2AppId_EHR)
	END
	--ELSE
	--BEGIN
	--	DELETE DGAM FROM [adm].[DoctorGroupApplicationMap] DGAM
	--	INNER JOIN [adm].[Groups] DG ON DGAM.dg_id = DG.dg_id
	--	WHERE DG.dc_id = @CompanyId_EHR AND 
	--	DGAM.ApplicationID = @PMV2AppId_EHR AND 
	--	(DG.dg_id = @GroupId_EHR OR @GroupId_EHR=0)
	--END
	-- PMV2 Bridge End
    -- ShedulerV2 Bridge Start
	IF @EnableSchedulerV2Bridge = 1
	BEGIN
		INSERT INTO doc_group_application_map (
			dg_id, ApplicationID
		)
		SELECT DG.dg_id,@SchedulerV2AppId_EHR 
		FROM doc_groups DG 
			INNER JOIN doc_companies DC ON DG.dc_id = DC.dc_id
		WHERE DC.dc_id = @CompanyId AND
			(DG.dg_id = @GroupId OR ISNULL(@GroupId,0) = 0) AND
			NOT EXISTS (SELECT 1 FROM doc_group_application_map DGAM 
						WHERE DGAM.dg_id = DG.dg_id AND DGAM.ApplicationID = @SchedulerV2AppId_EHR)
	END
	--ELSE
	--BEGIN
	--	DELETE DGAM FROM [ehr].[DoctorGroupApplicationMap] DGAM
	--	INNER JOIN [ehr].[Groups] DG ON DGAM.dg_id = DG.dg_id
	--	WHERE DG.dc_id = @CompanyId_EHR AND 
	--		DGAM.ApplicationID = @SchedulerV2AppId_EHR AND 
	--		(DG.dg_id = @GroupId_EHR OR @GroupId_EHR=0)
	--END
	-- ShedulerV2 Bridge End
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
