SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_UpdateExternalDirectoryImmediateResponse] 
@MessageType INT,
@Id BIGINT,
@MessageId VARCHAR(50),
@RequestTime DATETIME,
@ResponseTime DATETIME,
@Response VARCHAR(MAX),
@Result BIT
AS
BEGIN

    SET NOCOUNT ON
	DECLARE @TransactionLogId BIGINT
	
	DECLARE @PartnerId INT=262144,  
	@version VARCHAR(50)='v6.1'
	
	Update [dbo].[surescript_admin_message] 
	SET [messageid] =@MessageId
	,[response_type] = @Result
	,[response_text] = @Response
	,[send_date] = @RequestTime
	,[response_date] = @ResponseTime
	,[message_type]=@MessageType
	WHERE ID=@Id
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
