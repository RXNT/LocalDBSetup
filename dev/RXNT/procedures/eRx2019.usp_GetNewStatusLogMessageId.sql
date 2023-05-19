SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_GetNewStatusLogMessageId] 
@MessageId VARCHAR(50),
@RxId BIGINT,
@TransactionStartTime DATETIME,
@StatusCode VARCHAR(10),
@Description VARCHAR(255),
@StatusCodeQualifier VARCHAR(10)

AS
BEGIN
    SET NOCOUNT ON 
	INSERT INTO rxhub_status_log (ctrl_ref_num, trc_num, status_code, status_msg, status_code_qualifier, recved_date, init_date)
	VALUES (@MessageId, @RxId, @StatusCode, @Description, @StatusCodeQualifier, GETDATE(), @TransactionStartTime)
	SELECT SCOPE_IDENTITY() 
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
