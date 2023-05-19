CREATE TABLE [dbo].[direct_email_address_book] (
   [DirectAddressBookID] [int] NOT NULL
      IDENTITY (1,1),
   [DirectAddressOwnerType] [int] NOT NULL,
   [OwnerEntityID] [bigint] NOT NULL,
   [DirectAddressFullName] [varchar](255) NOT NULL,
   [DirectAddress] [varchar](255) NOT NULL,
   [ModifiedDate] [datetime] NULL,
   [MasterContactId] [bigint] NULL

   ,CONSTRAINT [PK_direct_email_address_book] PRIMARY KEY CLUSTERED ([DirectAddressBookID])
)


GO
