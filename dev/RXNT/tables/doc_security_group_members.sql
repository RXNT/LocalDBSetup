CREATE TABLE [dbo].[doc_security_group_members] (
   [dsgm_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dsg_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_security_group_members] PRIMARY KEY CLUSTERED ([dsgm_id])
)

CREATE NONCLUSTERED INDEX [IX_doc_security_group_members-dr_id] ON [dbo].[doc_security_group_members] ([dr_id])

GO
