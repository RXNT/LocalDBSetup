SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram
-- Create date: 14-Jun-2016
-- Description:	Save Epa Token Log
-- =============================================

CREATE PROCEDURE [epa].[usp_SaveEpaTokenLog]
(
	@DcId INT,
	@ProviderSPI VARCHAR(100),
	@EndUserId INT,
	@PaAuthRequestJson VARCHAR(MAX),
	@LoggedInUserId INT,
	@EpaTokenLogId BIGINT OUT
)
AS
BEGIN
	INSERT INTO [epa].[epa_token_log]
           ([dc_id]
		   ,[provider_spi]
           ,[end_user_id]
           ,[pa_auth_request_json]
           ,[created_date]
           ,[created_by])
     VALUES
           (@DcId
		   ,@ProviderSPI
           ,@EndUserId
           ,@PaAuthRequestJson
           ,GETDATE()
           ,@LoggedInUserId)
           
	SET @EpaTokenLogId = SCOPE_IDENTITY()
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
