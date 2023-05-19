CREATE TABLE [dbo].[tblHealthGuidelines] (
   [rule_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [gender] [varchar](2) NULL,
   [added_by_dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [is_active] [bit] NULL,
   [name] [varchar](255) NULL,
   [supporting_url] [varchar](512) NULL,
   [reco_interval_min_days] [int] NULL,
   [reco_interval_max_days] [int] NULL,
   [min_age_days] [int] NULL,
   [max_age_days] [int] NULL,
   [grade] [varchar](2) NULL,
   [description] [ntext] NOT NULL,
   [service_type_id] [tinyint] NULL,
   [RecurrenceRule] [nvarchar](1024) NULL

   ,CONSTRAINT [PK_tblHealthGuidelines] PRIMARY KEY CLUSTERED ([rule_id])
)

CREATE NONCLUSTERED INDEX [IX_tblHealthGuidelines] ON [dbo].[tblHealthGuidelines] ([dg_id], [is_active])

GO
