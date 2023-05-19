SET ANSI_NULLS ON 
GO
CREATE TRIGGER rights_DTrig ON dbo.rights FOR DELETE AS
/*
 * CASCADE DELETES TO 'doc_rights'
 */
DELETE doc_rights FROM deleted, doc_rights WHERE deleted.right_id = doc_rights.right_id
/*
 * CASCADE DELETES TO 'doc_securifty_group_rights'
 */
DELETE doc_securifty_group_rights FROM deleted, doc_securifty_group_rights WHERE deleted.right_id = doc_securifty_group_rights.right_id
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[rights_DTrig] ON [dbo].[rights]
GO

GO
