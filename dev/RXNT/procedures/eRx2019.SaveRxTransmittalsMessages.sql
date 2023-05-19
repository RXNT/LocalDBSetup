SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 14-AUG-2019
-- Description:	To save Rx Transmittals messages
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [eRx2019].[SaveRxTransmittalsMessages]
	@RxNTRxType VARCHAR(10),
	@DoctorId BIGINT,
	@PatientId BIGINT,
	@RequestId VARCHAR(50),
	@ResponseId VARCHAR(50),
	@StartDate DATE,
	@EndDate DATE,
	@RequestMessage XML,
	@ResponseMessage XML,
	@DeliveryMethod BIGINT
AS

BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM [erx].[RxTransmittalMessages]WITH(NOLOCK) WHERE RequestId = @RequestId)
	BEGIN
		INSERT INTO [erx].[RxTransmittalMessages]
		(RxType,DoctorId,PatientId,RequestId,ResponseId,StartDate,EndDate,RequestMessage,ResponseMessage,DeliveryMethod,CreatedDate)
		VALUES(@RxNTRxType,@DoctorId,@PatientId,@RequestId,NULL,@StartDate,NULL,@RequestMessage,NULL,@DeliveryMethod,GETDATE())
	END
	ELSE
	BEGIN
		UPDATE [erx].[RxTransmittalMessages] SET ResponseId=@ResponseId, ResponseMessage=@ResponseMessage,EndDate=@EndDate
		WHERE RequestId=@RequestId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
