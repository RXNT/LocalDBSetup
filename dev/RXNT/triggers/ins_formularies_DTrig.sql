SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
Create TRIGGER ins_formularies_DTrig ON dbo.ins_formularies FOR DELETE AS
/*
 * CASCADE DELETES TO 'ins_formulary_code_links'
 */
DELETE ins_formulary_code_links FROM deleted, ins_formulary_code_links WHERE deleted.if_id = ins_formulary_code_links.if_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[ins_formularies_DTrig] ON [dbo].[ins_formularies]
GO

GO
