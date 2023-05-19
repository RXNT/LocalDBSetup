SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram
-- Create date: 14-Jun-2016
-- Description:	Save Epa Transaction Log
-- =============================================

CREATE PROCEDURE [epa].[usp_SaveEpaTransactionLog]
(
	@PAInitRequestXml VARCHAR(MAX),
	@PAInitRequestJson VARCHAR(MAX),
	@PAReferenceId VARCHAR(100),
	@PaId INT,
	@DcId INT,
	@LoggedInUserId INT,
	@EpaTransactionLogId BIGINT OUT
)
AS
BEGIN
	INSERT INTO [epa].[epa_transaction_log]
           ([pa_init_request_xml]
		   ,[pa_init_request_json]
           ,[pa_reference_id]
           ,[pa_id]
           ,[dc_id]
           ,[created_date]
           ,[created_by])
     VALUES
           (@PAInitRequestXml
		   ,@PAInitRequestJson
           ,@PAReferenceId
           ,@PaId
           ,@DcId
           ,GETDATE()
           ,@LoggedInUserId)
           
	SET @EpaTransactionLogId = SCOPE_IDENTITY()
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
