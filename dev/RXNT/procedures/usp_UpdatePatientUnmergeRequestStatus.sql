SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdatePatientUnmergeRequestStatus]
(
	@PatientUnmergeRequestId BIGINT,
	@CompanyId BIGINT,
	@Status VARCHAR(50),
	@LoggedInUserId BIGINT,
	@RequestDate DATETIME = NULL,
	@Comments VARCHAR(MAX) = NULL
)
AS
BEGIN
	DECLARE @StatusId As INT
	SELECT @StatusId = StatusId FROM dbo.Patient_merge_status WITH (NOLOCK) WHERE Status = @Status
	DECLARE @CurrentDate AS DATETIME
	SET @CurrentDate = @RequestDate
	
	IF @RequestDate IS NULL
	BEGIN
		SET @CurrentDate = GETDATE()
	END
	UPDATE	dbo.PatientUnmergeRequests 
	SET		StatusId = @StatusId,
			ModifiedBy = @LoggedInUserId,
			ModifiedDate = @CurrentDate,
			Comments = Comments + ' ; ' + ISNULL(@Comments, '')
	WHERE	PatientUnmergeRequestId = @PatientUnmergeRequestId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
