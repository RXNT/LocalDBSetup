SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[vwMessagingUnreadCount] 
AS 
SELECT dr_id, folder_id, COUNT(message_id) AS unread_count 
FROM messaging_message_folders 
WHERE is_read = 0 
GROUP BY dr_id, folder_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
