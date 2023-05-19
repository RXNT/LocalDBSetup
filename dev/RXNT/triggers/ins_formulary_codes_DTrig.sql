SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
Create TRIGGER ins_formulary_codes_DTrig ON dbo.ins_formulary_codes FOR DELETE AS
/*
 * CASCADE DELETES TO 'ins_formulary_code_links'
 */
DELETE ins_formulary_code_links FROM deleted, ins_formulary_code_links WHERE deleted.ifc_id = ins_formulary_code_links.ifc_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[ins_formulary_codes_DTrig] ON [dbo].[ins_formulary_codes]
GO

GO
