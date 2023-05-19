CREATE TABLE [dbo].[doc_group_actions] (
   [dg_action_id] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [bigint] NULL

   ,CONSTRAINT [PK_doc_group_actions] PRIMARY KEY CLUSTERED ([dg_action_id])
)


GO
