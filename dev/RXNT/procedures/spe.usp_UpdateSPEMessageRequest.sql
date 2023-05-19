SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Vinod  
-- Create date: 17-April-2020
-- Description: Update SPO Initiation Request
-- =============================================  
  

CREATE PROCEDURE [spe].[usp_UpdateSPEMessageRequest]  
 @SPOId BIGINT,
 @RequestId VARCHAR(50),
 @Request VARCHAR(MAX),
 @ResponseId VARCHAR(50),
 @ResponseMessage VARCHAR(2000),
 @ResponseCode VARCHAR(10),
 @IsSuccess BIGINT,
 @RxId BIGINT,
 @RxDetailId BIGINT

AS  
BEGIN  
 DECLARE	@RetryAfterMinutes INT=10,
			@MaxRetryCount INT=3
 UPDATE [spe].SPEMessages 
 SET is_success = CASE WHEN @IsSuccess=1 THEN NULL ELSE @IsSuccess END ,request_id=@RequestId,Request=@Request,response_id=@ResponseId,response_message = @ResponseMessage,response_code = @ResponseCode,send_date=GETDATE(),response_date = GETDATE()
 WHERE pres_id = @RxId AND pd_id = @RxDetailId AND spo_ir_id = @SPOId
 IF NOT(@IsSuccess = 1)
 BEGIN
	 UPDATE [spe].SPEMessages 
	 SET next_retry_on = DATEADD(MINUTE,@RetryAfterMinutes,GETDATE()), retry_count = ISNULL(retry_count,0)+1 
	 WHERE pres_id = @RxId AND pd_id = @RxDetailId AND spo_ir_id = @SPOId
 END
END   
  

 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
