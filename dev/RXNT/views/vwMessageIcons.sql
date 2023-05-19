SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[vwMessageIcons] 
AS 
SELECT message_id, dr_id, folder_id, 

CASE WHEN is_read = 1 THEN
	'msg_read.gif'
ELSE
	'msg_unread.gif' 
END AS email_icon, 

'spacer.gif' AS priority_icon, 

'spacer.gif' AS attachment_icon, 

'flag_none.gif' AS flag_icon

FROM messaging_message_folders
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
