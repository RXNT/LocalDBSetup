SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
Create TRIGGER ins_carriers_DTrig ON dbo.ins_carriers FOR DELETE AS
/*
 * CASCADE DELETES TO 'ins_formularies'
 */
DELETE ins_formularies FROM deleted, ins_formularies WHERE deleted.ic_id = ins_formularies.ic_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[ins_carriers_DTrig] ON [dbo].[ins_carriers]
GO

GO
