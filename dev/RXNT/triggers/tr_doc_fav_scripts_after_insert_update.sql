SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER tr_doc_fav_scripts_after_insert_update
ON dbo.doc_fav_scripts
AFTER INSERT, UPDATE
AS
  DECLARE @ScriptId AS INTEGER, @UpdateCode AS INTEGER
  SELECT @ScriptId = script_id, @UpdateCode = update_code FROM inserted
  IF (@UpdateCode IS NULL OR @UpdateCode = 0) AND (UPDATE(ddid) OR UPDATE(dosage) OR UPDATE(use_generic) OR UPDATE(numb_refills) OR 
	UPDATE(duration_unit) OR UPDATE(duration_amount) OR UPDATE(comments))
    UPDATE doc_fav_scripts SET update_code = 10 WHERE script_id = @ScriptId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_doc_fav_scripts_after_insert_update] ON [dbo].[doc_fav_scripts]
GO

GO
