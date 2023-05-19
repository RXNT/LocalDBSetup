CREATE TABLE [dbo].[Address] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [Address1] [varchar](200) NOT NULL,
   [Address2] [varchar](200) NULL,
   [PostalCode] [varchar](20) NOT NULL,
   [City] [varchar](200) NOT NULL,
   [StateCode] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_Address_Id] PRIMARY KEY CLUSTERED ([Id])
)


GO
