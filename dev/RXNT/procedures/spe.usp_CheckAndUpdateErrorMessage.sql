SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [spe].[usp_CheckAndUpdateErrorMessage] 
@RelatesToMessageId VARCHAR(50),
@SPOResponseText VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @SPOId BIGINT
	SELECT TOP 1 @SPOId = spo_ir_id
	FROM spe.SPEMessages WITH(NOLOCK) 
	WHERE request_id=@RelatesToMessageId AND message_type=2  OPTION(MAXDOP 4)
 
	DECLARE @IsInvalidReuest BIT=0;
    IF (@SPOId > 0)
    BEGIN
    
		UPDATE spe.SPEMessages 
		SET async_response_date=GETDATE()
		,is_success= 0 
		,async_response= @SPOResponseText 
		WHERE spo_ir_id = @SPOId ; 
	                                 
	END
    ELSE
    BEGIN                    
		SET @IsInvalidReuest=1 --Invalid VERIFY request");   
	END
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
