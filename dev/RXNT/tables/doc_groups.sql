CREATE TABLE [dbo].[doc_groups] (
   [dg_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NULL,
   [dg_name] [varchar](80) NOT NULL,
   [beta_tester] [bit] NOT NULL,
   [sfi_group] [bit] NOT NULL,
   [sfi_patient_lookup] [bit] NULL,
   [payment_plan_id] [int] NOT NULL,
   [payment_reoccurrence] [tinyint] NOT NULL,
   [payment_month] [tinyint] NULL,
   [billing_date] [datetime] NULL,
   [reactivation_date] [varchar](50) NULL,
   [scheduled_enabled] [bit] NOT NULL,
   [default_dr_id] [int] NULL,
   [notes] [varchar](150) NULL,
   [status] [varchar](2) NULL,
   [comments] [varchar](600) NULL,
   [lab_status] [tinyint] NOT NULL,
   [emr_modules] [int] NOT NULL

   ,CONSTRAINT [PK_doc_groups] PRIMARY KEY NONCLUSTERED ([dg_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_doc_groups_23_7059161__K2_K1] ON [dbo].[doc_groups] ([dc_id], [dg_id])
CREATE NONCLUSTERED INDEX [IX_doc_groups_dc_id] ON [dbo].[doc_groups] ([dc_id])

GO
