SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetPendingUnmergeRequests]
AS
BEGIN
	SELECT	UNM.[PatientUnmergeRequestId],
			UNM.[pa_merge_batchid],
			UNM.[CompanyId], 
			UNM.CreatedBy,
			UNM.[StatusId],
			UNM.CheckBatchId
	FROM	dbo.PatientUnmergeRequests UNM WITH (NOLOCK)
			INNER JOIN dbo.Patient_merge_request_batch BAT WITH (NOLOCK) ON BAT.pa_merge_batchid = UNM.pa_merge_batchid and BAT.dc_id = UNM.CompanyId
			INNER JOIN dbo.Patient_merge_status STS WITH (NOLOCK) ON STS.StatusId = UNM.StatusId AND STS.Status = 'Pending'
	WHERE	UNM.Active = 1
	Order BY BAT.Created_date desc
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
