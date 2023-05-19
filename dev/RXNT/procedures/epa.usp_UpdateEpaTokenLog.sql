SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram
-- Create date: 15-Jun-2016
-- Description:	Update Epa Token Log
-- =============================================

CREATE PROCEDURE [epa].[usp_UpdateEpaTokenLog]
(
	@EpaTokenLogId BIGINT,
	@PaAuthResponseJson VARCHAR(MAX),
	@ApiAuthResponseJson VARCHAR(MAX),
	@LoggedInUserId INT
)
AS
BEGIN
	UPDATE [epa].[epa_token_log]
	SET [pa_auth_response_json] = @PaAuthResponseJson,
		[pa_auth_api_response_json]  = @ApiAuthResponseJson,
		[modified_date] = GETDATE(),
		[modified_by] = @LoggedInUserId
	WHERE  [epa_token_log_id] = @EpaTokenLogId	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
