CREATE TABLE [dbo].[direct_email_addresses] (
   [DirectAddressOwnerType] [int] NOT NULL,
   [OwnerEntityID] [bigint] NOT NULL,
   [DirectAddressPrefix] [varchar](255) NOT NULL,
   [OwnerFullName] [varchar](255) NOT NULL,
   [DirectPassword] [varchar](50) NOT NULL,
   [AgreementAccepted] [bit] NOT NULL,
   [DirectDomainID] [int] NOT NULL

   ,CONSTRAINT [PK_direct_email_addresses] PRIMARY KEY CLUSTERED ([DirectAddressOwnerType], [OwnerEntityID])
)

CREATE UNIQUE NONCLUSTERED INDEX [no_duplicate_addresses] ON [dbo].[direct_email_addresses] ([DirectAddressPrefix])

GO
