CREATE TABLE [dbo].[MichiganTargetPhysicians] (
   [DEA] [varchar](30) NOT NULL,
   [Last Name] [varchar](255) NULL,
   [First Name] [varchar](255) NULL,
   [Address1] [varchar](255) NULL,
   [Address2] [varchar](255) NULL,
   [City] [varchar](50) NULL,
   [State] [varchar](5) NULL,
   [Zip] [varchar](20) NULL,
   [Phone] [varchar](20) NULL,
   [Fax] [varchar](20) NULL,
   [faxed] [bit] NOT NULL,
   [not_interested] [bit] NOT NULL,
   [fax_date] [datetime] NULL,
   [comments] [varchar](255) NULL

   ,CONSTRAINT [PK_MichiganTargetPhysicians] PRIMARY KEY CLUSTERED ([DEA])
)


GO
