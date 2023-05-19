SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	07-Oct-2019
Description			:	This procedure is used to get save active token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ext].[usp_SaveEPCSToken] --11647,100,0
	@Action VARCHAR(10)=NULL,
	@TokenId BIGINT,
	@DoctorId	BIGINT,
	@StatusId	INT=NULL,
	@Comments VARCHAR(4000)=NULL,
	@UPSTrackingId VARCHAR(500)=NULL,
	@UPSLabelFile VARCHAR(50)=NULL,
	@ShippingFee VARCHAR(50)=NULL,
	@ShippingAddress1 VARCHAR(255)=NULL,
	@ShippingAddress2 VARCHAR(255)=NULL,
	@ShippingCity	VARCHAR(50)=NULL,
	@ShippingState	VARCHAR(2)=NULL,
	@ShippingZip	VARCHAR(50)=NULL,
	@ShippingToName	VARCHAR(100)=NULL,
	@ShipSubmitDate	DATETIME=NULL,
	@ShipmentIdentification	VARCHAR(100),
	@Email	VARCHAR(100)=NULL,
	@TokenSerialNo	VARCHAR(20)=NULL,
	@TokenType	INT=NULL,
	@IsActivated	BIT=NULL,
	@IsSigRequired	BIT=NULL,
	@LoggedInUserId BIGINT
AS
BEGIN
	/*
	Status List
	Requested = 0,//enIDProofCompleted = 0,
    Completed = 1,//enTokenSetupCompleted = 1,
    //TokenBillingCompleted = 2,
    //TokenShipped = 3,
    Cancelled = 4,//enTokenShipVoided
    Deactivated = 5,
    Processed = 6, //NEW
    None = -1,
    //SoftTokenInitiated = 99,
    //SoftTokenAssigned = 100,
    //enExperianSuccess = 101
    */
    IF LEN(@Comments)>0
		SET @Comments = '<br/>(' + convert(varchar(20),getdate(),120)+ ')' + @Comments
	ELSE
		SET @Comments=''
		
    IF @Action='REPLACE'
    BEGIN 
		IF @TokenType = 2
		BEGIN
			SET @Comments = '<br/>Replacement Token (' + convert(varchar(20),getdate(),120)+ ')'

		END
		UPDATE doc_token_info SET stage=5,comments=ISNULL(comments,'')+@Comments,last_edited_by=@LoggedInUserId,last_edited_on=GETDATE() WHERE doc_token_track_id = @TokenId AND dr_id=@DoctorId
		SET @Action='ADD'
	END 
	IF @Action='ADD'
	BEGIN
		INSERT INTO doc_token_info([dr_id]
			,[stage]
			,[comments]
			,[ups_tracking_id]
			,[ups_label_file]
			,[shipping_fee]
			,[shipping_address1]
			,[shipping_address2]
			,[shipping_city]
			,[shipping_state]
			,[shipping_zip]
			,[shipping_to_name]
			,[ship_submit_date]
			,[shipment_identification]
			,[email]
			,[token_serial_no]
			,[token_type]
			,[is_activated]
			,[IsSigRequired]
			,created_by
			,created_on )
			VALUES(@DoctorId,
			0,
			ISNULL(@Comments,''),
			ISNULL(@UPSTrackingId,''),
			ISNULL(@UPSLabelFile,''),
			ISNULL(CAST(@ShippingFee AS FLOAT),0),
			ISNULL(@ShippingAddress1,''),
			ISNULL(@ShippingAddress2,''),
			ISNULL(@ShippingCity,''),
			ISNULL(@ShippingState,''),
			ISNULL(@ShippingZip,''),
			ISNULL(@ShippingToName,''),
			@ShipSubmitDate,
			@ShipmentIdentification,
			@Email,
			@TokenSerialNo,
			@TokenType,
			@IsActivated,
			ISNULL(@IsSigRequired,0),
			@LoggedInUserId,
			GETDATE())
			
			SET @TokenId=SCOPE_IDENTITY();
    END
    ELSE IF @Action='UPDATE'
    BEGIN 
		UPDATE doc_token_info SET comments=ISNULL(comments,'')+@Comments
		,last_edited_by=@LoggedInUserId
		,last_edited_on=GETDATE()
		,[shipping_address1]=@ShippingAddress1
		,[shipping_address2]=@ShippingAddress2
		,[shipping_city]=@ShippingCity
		,[shipping_state]=@ShippingState
		,[shipping_zip]=@ShippingZip
		,[shipping_to_name]=@ShippingToName
		,[email]=@Email 
		WHERE doc_token_track_id = @TokenId AND dr_id=@DoctorId
	END 
    ELSE IF @Action='CANCEL'
    BEGIN 
		IF @TokenType = 2
		BEGIN
			SET @Comments = '<br/>(' + convert(varchar(20),getdate(),120)+ ')' + @Comments

		END

	
		UPDATE doc_token_info SET stage=4,is_activated=CASE WHEN is_activated=1 THEN 0 ELSE is_activated END,comments=ISNULL(comments,'')+@Comments,last_edited_by=@LoggedInUserId,last_edited_on=GETDATE() WHERE doc_token_track_id = @TokenId AND dr_id=@DoctorId
	END 
	ELSE IF @Action='DEACTIVATE'
    BEGIN 
		UPDATE doc_token_info SET stage=5,is_activated=0,comments=ISNULL(comments,'')+@Comments,last_edited_by=@LoggedInUserId,last_edited_on=GETDATE() WHERE doc_token_track_id = @TokenId AND dr_id=@DoctorId
	END 
	  
    SELECT @TokenId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
