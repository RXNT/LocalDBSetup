SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 23-Mar-2015
-- Description	: to update Patient data migration requests
-- Modified By	: 
-- Modified Date:
-- =============================================
CREATE PROCEDURE [adm].[usp_UpdatePatientDataMigrationRequests]
@requestId BIGINT,
@status INT
AS

BEGIN
	UPDATE [adm].[PatientDataMigrationRequests]  
	SET status=@status,migrated_on=GETDATE() 
	WHERE request_id=@requestId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
