SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SaveCancelRxResponse] 
@SenderPharmacyNCPDPNumber VARCHAR(15),
@DoctorSPI VARCHAR(20),
@RxId BIGINT,
@RxTransmitalId BIGINT,
@Note VARCHAR(50),
@ResponseType INT,
@RxNTRxType INT,
@RelatesToMessageId VARCHAR(50),
@MessageId VARCHAR(50),
@FullRequestMessage XML 
AS
BEGIN   
	DECLARE @Message TABLE (Message VARCHAR(MAX))
	DECLARE @DoctorGroupId INT,@DoctorCompanyId INT,@DoctorId INT, @AuthorizingDoctorId INT, @IsEPCSEnabled BIT,@PatientId INT,@PharmacyId INT,@RxDetailId INT
    SELECT *
    INTO #PrescriberInfo
    FROM [eRx2019].[ufn_GetPrescriberInfoBySPI](@DoctorSPI)
    IF @@ROWCOUNT !=1
    BEGIN
		INSERT INTO @Message VALUES('Active Prescriber Couldn''t be Found')
		SELECT * FROM @Message
		RETURN
    END
    
    SELECT  TOP 1 @DoctorId = DoctorId,@DoctorGroupId = DoctorGroupId, @DoctorCompanyId= DoctorCompanyId, @IsEPCSEnabled = IsEPCSEnabled
    FROM #PrescriberInfo
    
    SELECT  TOP 1 @PatientId=PatientId,@IsEPCSEnabled = IsEPCSEnabled,@RxDetailId = RxDetailId
    FROM [eRx2019].[ufn_GetRxInfoByRxId](@RxId,@DoctorCompanyId)
   
	
	IF ISNULL(@PharmacyId,0)<=0
	BEGIN
		SELECT  TOP 1 @PharmacyId=PharmacyId
		FROM [eRx2019].[ufn_GetPharmacyInfoByNCPDPNumber](@SenderPharmacyNCPDPNumber)
    END
    
    IF ISNULL(@PharmacyId,0)<=0
	BEGIN 
		INSERT INTO @Message VALUES('Pharmacy Couldn''t be Found')
		SELECT * FROM @Message
		RETURN
	END  
  
	DECLARE @DeliveryMethod BIGINT = 262144 ,@StartDate DATETIME=GETDATE(),@EndDate DATETIME=GETDATE()
	
    EXECUTE [eRx2019].SaveRxTransmittalsMessages @RxNTRxType=@RxNTRxType,@DoctorId=@DoctorId,@PatientId=@PatientId,@RequestId=@RelatesToMessageID, @ResponseId=@MessageId, @StartDate=@StartDate, @EndDate = @EndDate, @RequestMessage = @FullRequestMessage,@ResponseMessage = @FullRequestMessage,@DeliveryMethod = @DeliveryMethod
    
    SELECT @RxId=pres_id,@RxDetailId=pd_id FROM prescription_Cancel_transmittals WITH(NOLOCK) WHERE pct_id=@RxTransmitalId
	
	UPDATE prescription_details SET cancel_status=@ResponseType, cancel_status_text=@Note WHERE pd_id=@RxDetailId
	
	UPDATE prescription_Cancel_transmittals SET response_date=GETDATE(),response_type=@ResponseType,response_text=@Note WHERE pct_id = @RxTransmitalId
	
	UPDATE prescription_status SET cancel_req_response_date=GETDATE(),cancel_req_response_type=@ResponseType,cancel_req_response_text=@Note WHERE pd_id = @RxDetailId AND delivery_method=@DeliveryMethod

END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
