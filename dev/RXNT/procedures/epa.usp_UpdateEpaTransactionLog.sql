SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram
-- Create date: 15-Jun-2016
-- Description:	Update Epa Transaction Log
-- =============================================

CREATE PROCEDURE [epa].[usp_UpdateEpaTransactionLog]
(
	@EpaTransactionLogId BIGINT,
	@Code VARCHAR(10),
	@DescriptionCode VARCHAR(10) = NULL,
	@Description VARCHAR(1000)  = NULL,
	@PaInitResponseXml VARCHAR(MAX) = NULL,
	@ApiResponseJson VARCHAR(MAX) = NULL,
	@LoggedInUserId INT
)
AS
BEGIN
	UPDATE [epa].[epa_transaction_log]
	SET [epa_response_status_code] = @Code,
		[epa_response_description_code]  = @DescriptionCode,
		[epa_response_description] = @Description,
		[pa_init_response_xml] = @PaInitResponseXml,
		[pa_init_api_response_json] = @ApiResponseJson,
		[modified_date] = GETDATE(),
		[modified_by] = @LoggedInUserId
	WHERE  [epa_transaction_log_id] = @EpaTransactionLogId	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
