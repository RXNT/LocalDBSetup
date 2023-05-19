CREATE TABLE [dbo].[dr_custom_messages] (
   [dr_cst_msg_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_src_id] [int] NOT NULL,
   [dr_dst_id] [int] NOT NULL,
   [msg_date] [datetime] NOT NULL,
   [message] [text] NOT NULL,
   [is_read] [bit] NOT NULL,
   [is_complete] [bit] NULL,
   [patid] [bigint] NULL,
   [message_typeid] [int] NULL,
   [message_subtypeid] [int] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [inbox_delete] [bit] NULL,
   [outbox_delete] [bit] NULL,
   [dr_src_delete_id] [bigint] NULL,
   [dr_dst_delete_id] [bigint] NULL

   ,CONSTRAINT [PK_dr_custom_messages] PRIMARY KEY CLUSTERED ([dr_cst_msg_id])
)

CREATE NONCLUSTERED INDEX [IX_dr_custom_messages-dr_dst_id-is_read-patid-message_typeid-msg_date] ON [dbo].[dr_custom_messages] ([dr_dst_id], [is_read], [patid], [message_typeid], [msg_date])

GO
