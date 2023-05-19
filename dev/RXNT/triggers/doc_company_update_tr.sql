SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE      TRIGGER [dbo].[doc_company_update_tr]
on [dbo].[doc_companies]
AFTER UPDATE
AS 
  DECLARE @dc_id AS INTEGER
  DECLARE @partner_new AS int
  SELECT @dc_id = dc_id,@partner_new = partner_id
  FROM inserted
  

IF  update(partner_id)  
BEGIN
	DECLARE @partner_old AS int
	SELECT @partner_old = u.partner_id FROM DELETED U
	IF @partner_new != @partner_old
	BEGIN
		UPDATE dbo.doc_companies SET ModifiedDate = GETDATE() WHERE dc_id = @dc_id
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[doc_company_update_tr] ON [dbo].[doc_companies]
GO

GO
