SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CreatePatientUnmergeRequest]
(
	@MergeRequestBatchId BIGINT,
	@CompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@RequestDate DATETIME = NULL,
	@Comments VARCHAR(8000) = NULL,
	@CheckBatchId BIT = 1
)
AS
BEGIN
	DECLARE @CurrentDate AS DATETIME
	SET @CurrentDate = @RequestDate
	
	IF @RequestDate IS NULL
	BEGIN
		SET @CurrentDate = GETDATE()
	END
	
	DECLARE @StatusId As INT
	SELECT @StatusId = StatusId FROM dbo.Patient_merge_status WITH (NOLOCK) WHERE Status = 'Pending'
	
	INSERT INTO	dbo.PatientUnmergeRequests 
	(pa_merge_batchid, CompanyId, StatusId, Active, CreatedDate, CreatedBy, Comments, CheckBatchId)
	VALUES(@MergeRequestBatchId, @CompanyId, @StatusId, 1, @CurrentDate, @LoggedInUserId, @Comments, @CheckBatchId)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
