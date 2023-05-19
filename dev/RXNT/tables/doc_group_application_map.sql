CREATE TABLE [dbo].[doc_group_application_map] (
   [dg_application_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NOT NULL,
   [ApplicationID] [bigint] NOT NULL

   ,CONSTRAINT [PK_doc_group_application_map] PRIMARY KEY CLUSTERED ([dg_application_id])
)

CREATE NONCLUSTERED INDEX [ix_doc_group_application_map_dg_id_ApplicationID] ON [dbo].[doc_group_application_map] ([dg_id], [ApplicationID])

GO
