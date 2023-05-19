SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_CheckAndUpdateErrorMessage] 
@RelatesToMessageId VARCHAR(50),
@RxResponseText VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @RxDetailId BIGINT
    DECLARE @JobType INT
	SELECT TOP 1 @RxDetailId = transaction_id,@JobType = transaction_type 
	FROM RxNTReportUtils..rxhub_sig_transaction_log WITH(NOLOCK) 
	WHERE request_trace_id=@RelatesToMessageId OPTION  (MAXDOP 4)
 
	DECLARE @IsInvalidReuest BIT=0;
    IF (@RxDetailId > 0)
    BEGIN
            UPDATE prescription_status 
            SET response_date=GETDATE(), response_type= 1 , response_text= @RxResponseText 
            WHERE pd_id = @RxDetailId AND delivery_method = 262144 
	END
    ELSE
    BEGIN                    
		SET @IsInvalidReuest=1 --Invalid Error request");   
	END
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
