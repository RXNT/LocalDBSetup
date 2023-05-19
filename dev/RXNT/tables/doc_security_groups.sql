CREATE TABLE [dbo].[doc_security_groups] (
   [dsg_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsg_desc] [varchar](255) NOT NULL,
   [dsg_id_required_ids] [varchar](100) NULL,
   [rights] [bigint] NULL

   ,CONSTRAINT [PK_doc_security_groups] PRIMARY KEY CLUSTERED ([dsg_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [DescNoDupes] ON [dbo].[doc_security_groups] ([dsg_desc])

GO
