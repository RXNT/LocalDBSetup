CREATE TABLE [dbo].[encounter_datasets] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [displayName] [varchar](500) NOT NULL,
   [enable] [bit] NULL

   ,CONSTRAINT [PK_encounter_datasets] PRIMARY KEY CLUSTERED ([id])
)


GO
