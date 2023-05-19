SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 19-June-2015
-- Description:	To get the scheduler data migration request
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [adm].[usp_GetSchedulerDataMigrationRequest]
	@CompanyId BIGINT,
	@GroupId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	DECLARE @SchedulerV2AppId_EHR BIGINT
	  
		
	SELECT @SchedulerV2AppId_EHR = App.ApplicationId  
	FROM [Applications] App
	INNER JOIN [ApplicationTypes] AppType ON App.ApplicationTypeID = AppType.ApplicationTypeID 
	INNER JOIN [ApplicationVersions] AppVer ON App.ApplicationVersionID = AppVer.ApplicationVersionID 
	WHERE AppType.ApplicationTypeName = 'Scheduler' AND 
		AppVer.ApplicationVersion = 'Version2'
	
	SELECT request_id
	FROM [adm].[SchedulerDataMigrationRequests] 
	WHERE dc_id=@CompanyId AND dg_id=@GroupId AND ApplicationID=@SchedulerV2AppId_EHR
	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
