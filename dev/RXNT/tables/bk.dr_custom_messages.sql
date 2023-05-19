CREATE TABLE [bk].[dr_custom_messages] (
   [dr_cst_msg_id] [int] NOT NULL,
   [dr_src_id] [int] NOT NULL,
   [dr_dst_id] [int] NOT NULL,
   [msg_date] [datetime] NOT NULL,
   [message] [text] NOT NULL,
   [is_read] [bit] NOT NULL,
   [is_complete] [bit] NULL,
   [patid] [bigint] NULL,
   [message_typeid] [int] NULL,
   [message_subtypeid] [int] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
