CREATE TABLE [dbo].[direct_email_domains] (
   [DirectDomainID] [int] NOT NULL
      IDENTITY (1,1),
   [DirectDomainPrefix] [varchar](255) NOT NULL,
   [FacilityAdminUsername] [varchar](50) NOT NULL,
   [FacilityAdminPassword] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_direct_email_domains] PRIMARY KEY CLUSTERED ([DirectDomainID])
)

CREATE UNIQUE NONCLUSTERED INDEX [NoDuplicatePrefixes] ON [dbo].[direct_email_domains] ([DirectDomainPrefix])

GO
