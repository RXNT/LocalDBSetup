SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[trg_update_reftargetdocs] 
ON [dbo].[referral_target_docs]
FOR UPDATE 
AS 
BEGIN 
   IF NOT UPDATE(ModifiedDate) 
       UPDATE dbo.referral_target_docs SET ModifiedDate=GETDATE() 
       WHERE target_dr_id IN (SELECT target_dr_id FROM inserted) 
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[trg_update_reftargetdocs] ON [dbo].[referral_target_docs]
GO

GO
