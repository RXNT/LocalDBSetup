CREATE TABLE [dbo].[doc_groups_lab_info] (
   [doc_group_lab_xref_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [dg_lab_id] [varchar](50) NOT NULL,
   [lab_participant] [bigint] NOT NULL,
   [name] [varchar](50) NULL,
   [sender_mnemonics] [varchar](255) NULL,
   [bi_support] [bit] NULL,
   [account_key] [varchar](50) NULL,
   [external_lab_id] [varchar](50) NULL,
   [external_lab_name] [varchar](50) NULL,
   [auto_read_lab_result] [bit] NULL

   ,CONSTRAINT [PK_doc_groups_lab_info] PRIMARY KEY CLUSTERED ([doc_group_lab_xref_id])
)


GO
