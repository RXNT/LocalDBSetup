CREATE TABLE [dbo].[snomed_ct_code_system] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [Name] [nvarchar](500) NOT NULL,
   [Description] [varchar](1000) NULL,
   [SnomedCode] [nvarchar](50) NOT NULL,
   [Category] [varchar](100) NULL

   ,CONSTRAINT [PK_snomed_ct_code_system] PRIMARY KEY CLUSTERED ([Id])
)


GO
