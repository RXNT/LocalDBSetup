SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Venkatesh
-- Create date: 11-Dec-2015
-- Description:	Get System messages by doctor Id
-- =============================================
CREATE PROCEDURE [dbo].[GetSystemMessagesForDashboard] 
	@drid BIGINT
AS
BEGIN
	SELECT TOP 5 DM.DrMsgId,dm.DrMsgDate,DM.DrMsgBy,DM.DrMessage,CASE WHEN DMS.ReadDate IS NULL THEN 0 ELSE 1 END AS ReadStatus
	FROM doc_messages DM WITH(NOLOCK)
	LEFT JOIN doc_message_reads DMS WITH(NOLOCK) on DM.drmsgid=DMS.drmsgid AND DMS.dr_id=@drid
	ORDER BY DM.drmsgdate DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
