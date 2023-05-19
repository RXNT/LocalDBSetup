SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 23-Mar-2015
-- Description	: to fetch scheduler data migration requests
-- Modified By	: 
-- Modified Date:
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchSchedulerDataMigrationRequests]

AS

BEGIN
	SET NOCOUNT ON;
	
	SELECT request_id, dc_id, dg_id, ApplicationID, reuested_on, migrated_on, status
	FROM   [adm].[SchedulerDataMigrationRequests] SDMR
	WHERE SDMR.status = 1 AND 
	SDMR.migrated_on IS NULL
 
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
