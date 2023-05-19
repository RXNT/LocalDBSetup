SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_UpdateRxRenewalResponseType] 
 @RxId BIGINT,
 @RxRenewalResponseType  INT
AS
BEGIN
    
    DECLARE @enParticipant    BIGINT=262144,
    @version VARCHAR(200) =  'v6.1'
   
    IF @RxRenewalResponseType = 10 --RefillChanged
    BEGIN
		UPDATE refill_requests 
		SET response_type = 10 
		WHERE pres_id = @RxId
		EXEC [eRx2019].[SavePrescriptionVoidTransmittal]@RxId=@RxId,@DeliveryMethod = @enParticipant
	END
    ELSE IF @RxRenewalResponseType = 100 --RefillNumChanged
	BEGIN
		UPDATE refill_requests SET response_type = 100 WHERE pres_id = @RxId
	END
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
