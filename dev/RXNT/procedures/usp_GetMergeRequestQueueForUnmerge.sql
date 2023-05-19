SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetMergeRequestQueueForUnmerge]
(
	@MergeRequestBatchId BIGINT,
	@CompanyId BIGINT
)
AS
BEGIN
	SELECT	QUE.pa_merge_reqid, QUE.primary_pa_id, QUE.secondary_pa_id, QST.Status As MergeStatus, QUE.Status As StatusId
	FROM	dbo.Patient_merge_request_batch BAT WITH (NOLOCK)
			INNER JOIN dbo.Patient_merge_request_queue QUE WITH (NOLOCK) ON QUE.pa_merge_batchid = BAT.pa_merge_batchid
			INNER JOIN dbo.Patient_merge_status QST WITH (NOLOCK) on QST.StatusId = QUE.status
			INNER JOIN dbo.patients pat WITH (NOLOCK) on pat.pa_id = QUE.secondary_pa_id --AND pat.dg_id < 0
	WHERE	BAT.pa_merge_batchid = @MergeRequestBatchId
	Order BY QUE.created_date desc
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
