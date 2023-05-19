CREATE TABLE [dbo].[doc_group_module_info] (
   [dg_module_info_id] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_module_info] PRIMARY KEY CLUSTERED ([dg_module_info_id])
)


GO
