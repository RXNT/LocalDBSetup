CREATE TABLE [bk].[referral_main] (
   [ref_id] [int] NOT NULL,
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
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [old_target_dr_id] [bigint] NULL
)


GO
