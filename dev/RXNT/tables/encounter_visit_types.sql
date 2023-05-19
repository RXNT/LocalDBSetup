CREATE TABLE [dbo].[encounter_visit_types] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [code] [char](10) NOT NULL,
   [description] [nvarchar](500) NULL,
   [enable] [bit] NOT NULL

   ,CONSTRAINT [PK_encounter_visit_types] PRIMARY KEY CLUSTERED ([id])
)


GO
