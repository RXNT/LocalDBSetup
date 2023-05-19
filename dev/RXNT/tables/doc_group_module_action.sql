CREATE TABLE [dbo].[doc_group_module_action] (
   [dg_module_action_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_page_module_info_id] [int] NOT NULL,
   [dg_action_id] [int] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_module_action] PRIMARY KEY CLUSTERED ([dg_module_action_id])
)


GO
