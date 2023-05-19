SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: 01-Sep-2016
-- Description:	To update the status of patient queue
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [que].[usp_UpdatePatientQueueStatus]
	@CompanyId				BIGINT,
	@PatientQueueId			BIGINT,
	@QueueStatus			VARCHAR(5),
	@QueueCreatedDate		DATETIME,
	@QueueProcessStartDate	DATETIME,
	@QueueProcessEndDate	DATETIME,
	@JobId					BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	
	Update	que.PatientQueue
	Set		QueueStatus = @QueueStatus,
			QueueCreatedDate = Case When @QueueCreatedDate is null then 
								case when QueueCreatedDate IS NULL and @QueueProcessStartDate is not null 
										then  @QueueProcessStartDate else QueueCreatedDate end  
								else @QueueCreatedDate end,
			QueueProcessStartDate = Case When @QueueProcessStartDate is null then QueueProcessStartDate else @QueueProcessStartDate end,
			QueueProcessEndDate = Case When @QueueProcessEndDate is null then QueueProcessEndDate else @QueueProcessEndDate end,
			JobId = Case When @JobId = null then JobId else @JobId end
	Where	dc_id = @CompanyId
			And PatientQueueId = @PatientQueueId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
