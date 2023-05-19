CREATE TABLE [dbo].[doc_groups_ex1] (
   [dg_id] [int] NOT NULL,
   [businessday_start] [time] NULL,
   [businessday_end] [time] NULL

   ,CONSTRAINT [PK_doc_groups_ex1] PRIMARY KEY CLUSTERED ([dg_id])
)


GO
