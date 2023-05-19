SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_CheckAndUpdateVerifyMessage] 

@RelatesToMessageId VARCHAR(50),
@RxResponseText VARCHAR(MAX)=NULL
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @RxTransmitalId BIGINT
    DECLARE @RxDetailId BIGINT
    DECLARE @JobType INT
	SELECT TOP 1 @RxDetailId = transaction_id,@JobType=transaction_type 
	FROM RxNTReportUtils..rxhub_sig_transaction_log WITH(NOLOCK) 
	WHERE request_trace_id=@RelatesToMessageId  OPTION(MAXDOP 4)
 
	DECLARE @IsInvalidReuest BIT=0;
    IF (@RxDetailId > 0)
    BEGIN
                        --this.TraceNumber = precDetailId.ToString();
            IF @JobType IN (1,2,4,5)
            BEGIN 
				UPDATE prescription_transmittals 
				SET response_date=GETDATE()
				,response_type= 0 
				,response_text= @RxResponseText 
				WHERE pd_id = @RxDetailId ; 
	                                
				UPDATE prescription_status 
				SET response_date=GETDATE(), 
				response_type= 0 , 
				response_text= @RxResponseText 
				FROM prescription_status PS WITH(NOLOCK) 
				INNER JOIN prescription_transmittals PT WITH(NOLOCK) ON PS.pd_id=PT.pd_id and PS.delivery_method = 262144 
				WHERE PT.pd_id = @RxDetailId ; 
			END
			ELSE IF @JobType IN (3)
            BEGIN 
				UPDATE prescription_void_transmittals 
				SET response_date=GETDATE()
				,response_type= 0 
				,response_text= @RxResponseText 
				WHERE pd_id = @RxDetailId ; 
	                                
				UPDATE prescription_status 
				SET response_date=GETDATE(), 
				response_type= 0 , 
				response_text= @RxResponseText 
				FROM prescription_status PS WITH(NOLOCK) 
				INNER JOIN prescription_void_transmittals PT WITH(NOLOCK) ON PS.pd_id=PT.pd_id and PS.delivery_method = 262144 
				WHERE PT.pd_id = @RxDetailId ; 
			END
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
