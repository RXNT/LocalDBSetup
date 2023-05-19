SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 16-OCT-2017
-- Description:	Map Fill To Prescription
-- =============================================
CREATE PROCEDURE [erx].[MapRxFillToPrescription]
	@FillReqID BIGINT,
	@PresID BIGINT,
	@PdID BIGINT,
	@IsMapping BIT = 0
AS
BEGIN
	UPDATE dbo.prescription_details SET FillReqId=@FillReqID WHERE pres_id=@PresID AND pd_id=@PdID
	IF EXISTS(SELECT TOP 1 1 FROM erx.RxFillRequests WHERE FillReqId=@FillReqID AND @IsMapping = 1)
	BEGIN
		UPDATE erx.RxFillRequests SET PresId=@PresID, PrescriberOrderNumber=@PresID WHERE FillReqId=@FillReqID
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
