SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 19-June-2015
-- Description:	Save scheduler data migration request
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveSchedulerDataMigrationRequest]
	@CompanyId BIGINT,
	@GroupId BIGINT 
AS

BEGIN
	SET NOCOUNT ON;
	DECLARE @PMV2AppId_EHR BIGINT,
			@SchedulerV2AppId_EHR BIGINT
	 
		
	SELECT @SchedulerV2AppId_EHR = App.ApplicationId  
	FROM [Applications] App
	INNER JOIN [ApplicationTypes] AppType ON App.ApplicationTypeID = AppType.ApplicationTypeID 
	INNER JOIN [ApplicationVersions] AppVer ON App.ApplicationVersionID = AppVer.ApplicationVersionID 
	WHERE AppType.ApplicationTypeName = 'Scheduler' AND 
		AppVer.ApplicationVersion = 'Version2'
	 
	IF NOT EXISTS(SELECT TOP 1 1 
	FROM [adm].[SchedulerDataMigrationRequests] 
	WHERE dc_id=@CompanyId AND dg_id=@GroupId AND ApplicationID=@SchedulerV2AppId_EHR)
	BEGIN
		INSERT INTO [adm].[SchedulerDataMigrationRequests]
           ([dc_id]
           ,[dg_id]
           ,[ApplicationID]
           ,[reuested_on]
           ,[status])
		 VALUES
			   (@CompanyId
			   ,@GroupId
			   ,@SchedulerV2AppId_EHR
			   ,GETDATE()
			   ,1-- Pending
			   )


	END
	 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
