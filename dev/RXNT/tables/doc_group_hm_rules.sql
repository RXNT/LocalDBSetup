CREATE TABLE [dbo].[doc_group_hm_rules] (
   [rule_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [gender] [varchar](2) NULL,
   [added_by_dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [is_active] [bit] NULL,
   [name] [varchar](255) NULL,
   [supporting_url] [varchar](512) NULL,
   [min_age_days] [int] NULL,
   [max_age_days] [int] NULL,
   [description] [ntext] NOT NULL

   ,CONSTRAINT [PK_doc_group_hm_rules] PRIMARY KEY CLUSTERED ([rule_id])
)


GO
