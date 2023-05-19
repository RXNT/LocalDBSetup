SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_UpdateExternalRxImmediateResponse] 
@JobType INT,
@RxTransmitalId BIGINT,
@RxDetailId BIGINT,
@MessageId VARCHAR(50),
@TransactionStartTime DATETIME,
@TransactionEndTime DATETIME,
@Request VARCHAR(MAX),
@Response VARCHAR(MAX),
@Description VARCHAR(MAX),
@StatusCode VARCHAR(10),
@HasSQLException BIT,
@RetryAfterMinutes INT,
@MaxRetryCount INT,
@IsSuccess BIT,
@RxId BIGINT=NULL,
@IsSpecialty BIT=NULL,
@HasRxFillStatus BIT=NULL
AS
BEGIN

    SET NOCOUNT ON
	DECLARE @TransactionLogId BIGINT
	
	DECLARE @PartnerId INT=262144,  
	@version VARCHAR(50)='v6.1'
	
	DECLARE @ResponseText VARCHAR(500)=SUBSTRING(ISNULL(CASE WHEN @HasSQLException=1 THEN 'Transaction failed' ELSE @Description END,''),1,255)
	INSERT INTO RxNTReportUtils..rxhub_sig_transaction_log (transaction_id, transaction_trace_reference, transaction_type, request_date, request_trace_id) 
	VALUES (@RxDetailId,ISNULL(@MessageId,''),@JobType,@TransactionStartTime,ISNULL(@MessageId,''))
	SET @TransactionLogId = SCOPE_IDENTITY();
    INSERT INTO RxNTReportUtils..rxhub_sig_transaction_details_log (rstl_id, transaction_id, transaction_trace_reference, response_date, response_code, response_code_qualifier, response_message,request_message,raw_response) 
    VALUES (@TransactionLogId ,'','',@TransactionEndTime,@StatusCode,'',@ResponseText,@Request,@Response)
                              
    IF @HasSQLException=1
    BEGIN
		IF (@JobType = 3)--CancelRxRequest
		BEGIN
			UPDATE prescription_Cancel_transmittals  
			SET next_retry_on = DATEADD(MINUTE,@RetryAfterMinutes,GETDATE()), retry_count = ISNULL(retry_count,0)+1 
			WHERE pct_id = @RxTransmitalId
			IF EXISTS(SELECT TOP 1 * FROM  prescription_Cancel_transmittals WITH(NOLOCK)  WHERE pct_id = @RxTransmitalId AND retry_count = @MaxRetryCount )
			BEGIN
				UPDATE prescription_status SET response_date=GETDATE(),response_type=CASE WHEN @IsSuccess=1 THEN 0 ELSE 1 END,response_text=@ResponseText WHERE pd_id = @RxDetailId AND delivery_method=@PartnerId
			END
			ELSE
			BEGIN
				UPDATE prescription_status SET response_text='Pending..waiting for retry' WHERE pd_id = @RxDetailId AND delivery_method=@PartnerId
			END
			
		END
        ELSE IF (@JobType = 4)--RxRenewalResponseDeclined
        BEGIN
            UPDATE prescription_void_transmittals 
            SET next_retry_on = DATEADD(MINUTE,@RetryAfterMinutes,GETDATE()), retry_count = ISNULL(retry_count,0)+1 
            WHERE pvt_id =@RxTransmitalId;
        END
		ELSE IF (@JobType = 7)--RxChangeResponseDeclined
        BEGIN
            UPDATE erx.RxChangeVoidTransmittals 
            SET next_retry_on = DATEADD(MINUTE,@RetryAfterMinutes,GETDATE()), retry_count = ISNULL(retry_count,0)+1 
            WHERE ChgVoidId =@RxTransmitalId;
        END
        ELSE
        BEGIN
            UPDATE prescription_transmittals 
            SET next_retry_on = DATEADD(MINUTE,@RetryAfterMinutes,GETDATE()), retry_count = ISNULL(retry_count,0)+1 
            WHERE pt_id =@RxTransmitalId
            
			IF EXISTS(SELECT TOP 1 * FROM  prescription_transmittals WITH(NOLOCK)  WHERE pt_id = @RxTransmitalId AND retry_count = @MaxRetryCount )
			BEGIN
                UPDATE prescription_transmittals 
                SET send_date = GETDATE(), response_date = GETDATE(), response_type = @IsSuccess, response_text = @ResponseText  
                WHERE pt_id =@RxTransmitalId
                UPDATE prescription_status 
                SET response_date=GETDATE(),response_type=CASE WHEN @IsSuccess=1 THEN 0 ELSE 1 END,response_text=@ResponseText 
                WHERE pd_id = @RxDetailId AND delivery_method=@PartnerId
            END 
			ELSE
			BEGIN
				UPDATE prescription_status SET response_text='Pending..waiting for retry' WHERE pd_id = @RxDetailId AND delivery_method=@PartnerId
			END
	     END
	END
    ELSE
    BEGIN
		IF (@JobType = 3)--CancelRxRequest
		BEGIN
			UPDATE prescription_Cancel_transmittals SET send_date = GETDATE(),response_date=GETDATE(),response_type=@IsSuccess,response_text=@ResponseText WHERE pct_id = @RxTransmitalId
	
			UPDATE prescription_status SET response_date=GETDATE(),response_type=CASE WHEN @IsSuccess=1 THEN 0 ELSE 1 END,response_text=@ResponseText WHERE pd_id = @RxDetailId AND delivery_method=@PartnerId
			
		END
        ELSE IF (@JobType = 4)--RxRenewalResponseDeclined
        BEGIN
            UPDATE prescription_void_transmittals 
            SET send_date = GETDATE(),response_date=GETDATE(),response_type=@IsSuccess,response_text=@ResponseText 
            WHERE pvt_id = @RxTransmitalId
        END
		ELSE IF (@JobType = 7)--RxChangeResponseDeclined
        BEGIN
            UPDATE erx.RxChangeVoidTransmittals 
            SET SendDate = GETDATE(),ResponseDate=GETDATE(),ResponseType=@IsSuccess,ResponseText=@ResponseText 
            WHERE ChgVoidId = @RxTransmitalId
        END
        ELSE
        BEGIN
            UPDATE prescription_transmittals 
            SET send_date = GETDATE(),response_date=GETDATE(),response_type=@IsSuccess,response_text=@ResponseText 
            WHERE pt_id = @RxTransmitalId
            UPDATE prescription_status SET response_date=GETDATE(),response_type=CASE WHEN @IsSuccess=1 THEN 0 ELSE 1 END,response_text=@ResponseText 
            WHERE pd_id = @RxDetailId AND delivery_method=@PartnerId
            IF (@JobType = 1 AND @IsSpecialty=1)--NewRx
            BEGIN
				IF NOT EXISTS(SELECT * FROM [spe].[SPEMessages] WHERE pres_id=@RxId AND pd_id=@RxDetailId AND message_type=2)
				BEGIN
					INSERT INTO [spe].[SPEMessages] (pres_id,pd_id,queued_date,message_type) VALUES (@RxId,@RxDetailId,GETDATE(),2)
				END
            END
			  
        END
	END
	IF @HasRxFillStatus IS NOT NULL
	BEGIN
		UPDATE prescription_details SET has_rxfillstatus = @HasRxFillStatus
		WHERE pres_id=@RxId AND pd_id=@RxDetailId 
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
