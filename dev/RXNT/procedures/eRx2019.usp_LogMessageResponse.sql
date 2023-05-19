SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_LogMessageResponse] 
 @MessageType BIGINT,
 @JobType INT,
 @RxId BIGINT,
 @RxDetailId  BIGINT,
 @RxTransmitalid BIGINT,
 @Deliverymethod INT,
 @RequestMessageId VARCHAR(50),
 @StartTime DATETIME,
 @EndTime DATETIME,
 @ResponseStatusCode VARCHAR(50),
 @ResponseStatusCodeQualifier VARCHAR(50),
 @TransactionControlRef VARCHAR(50),
 @ResponseText VARCHAR(MAX),
 @RequestText VARCHAR(MAX),
 @HasSQLException BIT,
 @RetryAfterMinutes INT,
 @MaxRetryCount INT,
 @ResponseType BIT
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @TransactionLogId BIGINT
                  
    IF @MessageType='RefillChanged'
    BEGIN
        UPDATE refill_requests SET response_type = 10 WHERE pres_id =@RxId
		EXEC insertPrescriptionVoidTransmittal @RxId, @Deliverymethod;
    END
	ELSE IF (@MessageType = 'RefillNumChanged')
    BEGIN
		UPDATE refill_requests SET response_type = 100 WHERE pres_id =@RxId
    END
    ELSE
    BEGIN
		INSERT INTO RxNTReportUtils..rxhub_sig_transaction_log
		(transaction_id, transaction_trace_reference, transaction_type, request_date, request_trace_id) 
		VALUES (@RxDetailId,@RequestMessageId,@JobType,@StartTime,@RequestMessageId);
        SET @TransactionLogId = SCOPE_IDENTITY()
               
        INSERT INTO RxNTReportUtils..rxhub_sig_transaction_details_log 
        (rstl_id, transaction_id, transaction_trace_reference, response_date, response_code, response_code_qualifier, response_message,request_message,raw_response) 
        VALUES (@TransactionLogId,@TransactionControlRef,@RequestMessageId,@EndTime,@ResponseStatusCode,@ResponseStatusCodeQualifier,SUBSTRING(@ResponseText,1,255),@RequestText,@ResponseText)
                    IF (@HasSQLException=1)
                    BEGIN
                        IF @JobType = 'enRefDec'
                        BEGIN
                            UPDATE prescription_void_transmittals SET next_retry_on = DATEADD(MINUTE,@RetryAfterMinutes,GETDATE()), retry_count = ISNULL(retry_count,0)+1 WHERE pvt_id = @RxTransmitalid;
                        END
                        ELSE
                        BEGIN
                            UPDATE prescription_transmittals SET next_retry_on = DATEADD(MINUTE,@RetryAfterMinutes,GETDATE()), retry_count = ISNULL(retry_count,0)+1 WHERE pt_id = @RxTransmitalid;
                            
                            

                            IF EXISTS(SELECT TOP 1 * FROM  prescription_transmittals WITH(NOLOCK)  WHERE pt_id = @RxTransmitalid AND retry_count = @MaxRetryCount)
                            BEGIN
                                   UPDATE prescription_transmittals SET send_date = GETDATE(), response_date = GETDATE(), response_type = @ResponseType , response_text = CASE WHEN @HasSQLException =1 THEN 'Transaction failed' ELSE @ResponseText END WHERE pt_id = @RxTransmitalid 
                                   UPDATE prescription_status SET response_date=GETDATE(),response_type=@ResponseType  ,response_text= CASE WHEN @HasSQLException =1 THEN 'Transaction failed' ELSE response_text END WHERE pd_id = @RxDetailId  AND delivery_method=@Deliverymethod
                            END 

                            
                            
                        END
                    END
                    ELSE
                    BEGIN
                        IF @JobType = 'enRefDec'
                        BEGIN
                            UPDATE prescription_void_transmittals SET send_date = GETDATE(),response_date=GETDATE(),response_type=@ResponseType ,response_text=@ResponseText WHERE pvt_id = @RxTransmitalid;
						END
                        ELSE
                        BEGIN
                            UPDATE prescription_transmittals SET send_date = GETDATE(),response_date=GETDATE(),response_type=@ResponseType ,response_text=@ResponseText WHERE pt_id = @RxTransmitalid
                            
                            

                            UPDATE prescription_status SET response_date=GETDATE(),response_type=@ResponseType ,response_text=CASE WHEN @HasSQLException=1 THEN 'Transaction failed' ELSE response_text END WHERE pd_id = @RxDetailId  AND delivery_method=@Deliverymethod;
                       END
			END
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
