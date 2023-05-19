SET ANSI_NULLS ON 
GO
Create TRIGGER doc_messages_DTrig ON dbo.doc_messages FOR DELETE AS
/*
 * CASCADE DELETES TO 'doc_message_reads'
 */
DELETE doc_message_reads FROM deleted, doc_message_reads WHERE deleted.DrMsgID = doc_message_reads.DrMsgID
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[doc_messages_DTrig] ON [dbo].[doc_messages]
GO

GO
