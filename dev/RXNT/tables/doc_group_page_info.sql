CREATE TABLE [dbo].[doc_group_page_info] (
   [dg_page_info_id] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [bigint] NULL

   ,CONSTRAINT [PK_doc_group_page_info] PRIMARY KEY CLUSTERED ([dg_page_info_id])
)


GO
