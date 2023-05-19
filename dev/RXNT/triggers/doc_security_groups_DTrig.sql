SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[doc_security_groups_DTrig] ON [dbo].[doc_security_groups] FOR DELETE AS
/*
 * CASCADE DELETES TO 'doc_security_group_rights'
 */
DELETE doc_security_group_rights FROM deleted, doc_security_group_rights WHERE deleted.dsg_id = doc_security_group_rights.dsg_id
/*
 * CASCADE DELETES TO 'doc_security_group_members'
 */
DELETE doc_security_group_members FROM deleted, doc_security_group_members WHERE deleted.dsg_id = doc_security_group_members.dsg_id
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[doc_security_groups_DTrig] ON [dbo].[doc_security_groups]
GO

GO
