SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1-Feb-2018
-- Description:	To update QDM data import status flag
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SaveMeasureRequestStatus]
	@RequestId BIGINT,
	@StatusId INT  
AS
BEGIN
	UPDATE [cqm2018].[DoctorCQMCalculationRequest]
	SET StatusId = @StatusId,
	LastModifiedOn = GETDATE()
	WHERE RequestId = @RequestId

	IF(@StatusId = 3)
	BEGIN
		UPDATE [cqm2018].[DoctorCQMCalculationRequest]
		SET RetryCount = ISNULL(RetryCount,0)+1
		WHERE RequestId = @RequestId
	END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
