SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 25-SEP-2017
-- Description:	To save Rx Fill Requests
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[SaveRxFillRequests]
	@FillRequestId BIGINT,
	@DoctorGroupId BIGINT,
	@DoctorId BIGINT,
	@PatientId BIGINT,
	@FillReqDate DATE,
	@PresId BIGINT,
	@PrescriberOrderNumber VARCHAR(100),
	@MessageId VARCHAR(100),
	@MsgDate DATE,
	@FillStatus VARCHAR(MAX),
	@FillStatusType INT,
	@DeliveryMethod BIGINT,
	@DrugName VARCHAR(125),
	@DrugNDC VARCHAR(11),
	@DrugFormCode VARCHAR(15),
	@DrugFormSourceCode VARCHAR(3),
	@DrugStrength VARCHAR(70),
	@DrugStrengthCode VARCHAR(15),
	@DrugStrengthSourceCode VARCHAR(3),
	@Qty1 VARCHAR(35),
	@Qty2 VARCHAR(35),
	@Qty1Units VARCHAR(50),
	@Qty2Units VARCHAR(50),
	@Qty1Enum TINYINT,
	@Qty2Enum TINYINT,
	@Dosage1 VARCHAR(140),
	@DaysSupply INT,
	@Date1 SMALLDATETIME,
	@Date2 SMALLDATETIME,
	@Date3 SMALLDATETIME,
	@Date1Enum TINYINT,
	@Date2Enum TINYINT,
	@Date3Enum TINYINT,
	@SubstitutionCode TINYINT,
	@Comments1 VARCHAR(210),
	@DispDrugInfo BIT,
	@DocInfoText VARCHAR(5000),
	@Refills VARCHAR(35),
	@RefillsType TINYINT,
	@FullReqMessage XML,
	@HasMismatch BIT=0,
	@MisMatchReason VARCHAR(MAX)=NULL,
	@PharmId BIGINT=0
AS

BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM [erx].[RxFillRequests] WHERE FillReqId = @FillRequestId)
	BEGIN
		INSERT INTO [erx].[RxFillRequests]
		(DoctorGroupId, DoctorId, PatientId, RequestDate, PresId, PrescriberOrderNumber, MessageId, InitDate, MsgDate, FillStatus, FillStatusType, DeliveryMethod, FullReqMessage, HasMissMatch, MissMatchReason)
		VALUES(@DoctorGroupId,@DoctorId,@PatientId,@FillReqDate,@PresId,@PrescriberOrderNumber,@MessageId,GETDATE(),@MsgDate,@FillStatus, @FillStatusType, @DeliveryMethod, @FullReqMessage, @HasMismatch, @MisMatchReason)
		SELECT SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE [erx].[RxFillRequests] SET DrugName=@DrugName,DrugNDC=@DrugNDC,DrugFormCode=@DrugFormCode,DrugFormSourceCode=@DrugFormSourceCode,
		DrugStrength=@DrugStrength,DrugStrengthCode=@DrugStrengthCode,DrugStrengthSourceCode=@DrugStrengthSourceCode,Qty1=@Qty1,Qty2=@Qty2,
		Qty1Units=@Qty1Units,Qty2Units=@Qty2Units,Qty1Enum=@Qty1Enum,Qty2Enum=@Qty2Enum,Dosage1=@Dosage1,DaysSupply=@DaysSupply,Date1=@Date1,
		Date2=@Date2,Date3=@Date2,Date1Enum=@Date1Enum,Date2Enum=@Date2Enum,Date3Enum=@Date3Enum,SubstitutionCode=@SubstitutionCode, 
		Refills=@Refills,RefillsType=@RefillsType,Comments1=@Comments1,DispDrugInfo=@DispDrugInfo,DocInfoText=@DocInfoText,PharmId=@PharmId
		WHERE FillReqId = @FillRequestId
		SELECT @FillRequestId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
