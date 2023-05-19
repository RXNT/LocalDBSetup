CREATE TABLE [dbo].[group_sponsors] (
   [dg_id] [int] NOT NULL,
   [sponsor_id] [int] NOT NULL

   ,CONSTRAINT [PK_group_sponsors] PRIMARY KEY CLUSTERED ([dg_id], [sponsor_id])
)


GO
