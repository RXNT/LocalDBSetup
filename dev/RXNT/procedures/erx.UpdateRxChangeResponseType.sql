SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	20-SEP-2017
-- Description:		Update Rx Change Response Type
-- =============================================
CREATE PROCEDURE [erx].[UpdateRxChangeResponseType]
  @DeliveryMethod			BIGINT,
  @PresId					BIGINT,
  @ResponseType				INT,
  @VoidCode					INT,
  @VoidComments				VARCHAR(255),
  @PriorAuthNum				VARCHAR(30),
  @ChgReqId					BIGINT=NULL
AS
BEGIN
	IF(ISNULL(@ChgReqId,0)=0)
		BEGIN
			SELECT @ChgReqId=ChgReqId FROM erx.RxChangeRequests WHERE PresId=@PresId
		END
	DECLARE @IsVoided AS BIT=0
	DECLARE @IsApproved AS BIT=0
	IF(@ResponseType = 0)
		BEGIN
			SET @IsVoided=1
		END
	IF(@ResponseType = 1 OR @ResponseType = 10)
		BEGIN
			SET @IsApproved=1
			IF(ISNULL(@PriorAuthNum,'')='')
				BEGIN
					SELECT @PriorAuthNum=PriorAuthNum FROM erx.RxChangeRequests WHERE ChgReqId=@ChgReqId
			END
	END
	UPDATE erx.RxChangeRequests SET ResponseType=@ResponseType,VoidCode=@VoidCode, VoidComments=@VoidComments, PriorAuthNum=@PriorAuthNum,IsVoided=@IsVoided,IsApproved=@IsApproved
	WHERE PresId=@PresId AND DeliveryMethod=@DeliveryMethod
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
