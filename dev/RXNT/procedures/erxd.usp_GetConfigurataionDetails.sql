SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [erxd].[usp_GetConfigurataionDetails]
	@pharm_participant  BIGINT,
	@version  DECIMAL
AS
BEGIN
	SELECT 
	[erx_url],[erx_login],[erx_password],[admin_url],[admin_login],[admin_password],[admin_portal_id],
	[admin_account_id],[pharmacy_download_url],[pharmacy_download_login],[pharmacy_download_password],[data_provider_id]
 FROM pharmacy_partner_config WHERE pharm_participant=@pharm_participant AND version=@version 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
