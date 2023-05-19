SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: 24-Oct-2016
-- Description:	To archive patient queue 
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [que].[usp_ArchivePatientQueue]
	@ArchiveDays	INT
AS

BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CurrentDate As DateTime
	
	SET @CurrentDate = GETDATE()
	
	INSERT INTO que.PatientQueueArchive
			(PatientQueueId, pa_id, dc_id, ActionType, OwnerType, QueueStatus, CreatedDate, CreatedBy, 
			ModifiedDate, ModifiedBy, QueueCreatedDate, QueueProcessStartDate, QueueProcessEndDate, JobId, ArchiveDate)
	SELECT	PatientQueueId, pa_id, dc_id, ActionType, OwnerType, QueueStatus, CreatedDate, CreatedBy, 
			ModifiedDate, ModifiedBy, QueueCreatedDate, QueueProcessStartDate, QueueProcessEndDate, JobId, @CurrentDate
	FROM	que.PatientQueue WITH (NOLOCK)
	WHERE	DATEDIFF(day, CreatedDate, @CurrentDate) > @ArchiveDays 
	
	DELETE	FROM	que.PatientQueue
	WHERE	DATEDIFF(day, CreatedDate, @CurrentDate) > @ArchiveDays 
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
