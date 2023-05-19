CREATE TABLE [dbo].[AugustTargetDocs] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [DEA] [nvarchar](255) NULL,
   [LastName] [nvarchar](255) NULL,
   [FirstName] [nvarchar](255) NULL,
   [Address] [nvarchar](255) NULL,
   [Address2] [nvarchar](255) NULL,
   [City] [nvarchar](255) NULL,
   [State] [nvarchar](255) NULL,
   [Zip] [nvarchar](255) NULL,
   [Phone] [float] NULL,
   [Fax] [float] NULL,
   [dg_id] [int] NULL

   ,CONSTRAINT [PK_AugustTargetDocs] PRIMARY KEY CLUSTERED ([id])
)


GO
