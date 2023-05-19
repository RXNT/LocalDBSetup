SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[UpdateDirectEmailAddressBookContactIdBySync]
(
   @AddressBookId int,
   @MasterContactId int
)
AS
	BEGIN
		update [dbo].[direct_email_address_book] 
			set MasterContactId = @MasterContactId
			 where DirectAddressBookID=@AddressBookId
		
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
