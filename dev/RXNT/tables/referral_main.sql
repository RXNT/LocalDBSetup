CREATE TABLE [dbo].[referral_main] (
   [ref_id] [int] NOT NULL
      IDENTITY (1,1),
   [main_dr_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [ref_det_xref_id] [int] NOT NULL,
   [ref_start_date] [datetime] NOT NULL,
   [ref_end_date] [datetime] NOT NULL,
   [carrier_xref_id] [int] NOT NULL,
   [pa_member_no] [varchar](50) NOT NULL,
   [ref_det_ident] [varchar](2) NOT NULL,
   [main_prv_id1] [varchar](50) NOT NULL,
   [main_prv_id2] [varchar](50) NOT NULL,
   [target_prv_id1] [varchar](50) NOT NULL,
   [target_prv_id2] [varchar](50) NOT NULL,
   [inst_id] [int] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [old_target_dr_id] [bigint] NULL,
   [case_id] [bigint] NULL,
   [group_number] [varchar](50) NULL,
   [payer_name] [varchar](100) NULL,
   [policy_number] [varchar](50) NULL,
   [insurance_start_date] [varchar](50) NULL,
   [insurance_end_date] [varchar](50) NULL,
   [referral_version] [varchar](50) NULL,
   [patient_new_allergies] [varchar](15) NULL

   ,CONSTRAINT [PK_referral_main] PRIMARY KEY CLUSTERED ([ref_id])
)

CREATE NONCLUSTERED INDEX [IDX_referral_main_pa_id] ON [dbo].[referral_main] ([pa_id])
CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[referral_main] ([ref_id], [main_dr_id], [target_dr_id], [pa_id], [carrier_xref_id], [inst_id])
CREATE NONCLUSTERED INDEX [IX_referral_main-main_dr_id-ref_start_date-incld] ON [dbo].[referral_main] ([main_dr_id], [ref_start_date]) INCLUDE ([ref_id], [target_dr_id], [inst_id])

GO
