SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[trg_update_directemailaddressbook] 
ON [dbo].[direct_email_address_book]
FOR UPDATE 
AS 
BEGIN 
   IF NOT UPDATE(ModifiedDate) 
       UPDATE dbo.direct_email_address_book SET ModifiedDate=GETDATE() 
       WHERE DirectAddressBookID IN (SELECT DirectAddressBookID FROM inserted) 
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[trg_update_directemailaddressbook] ON [dbo].[direct_email_address_book]
GO

GO
