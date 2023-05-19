CREATE TABLE [bk].[patient_reg_db] (
   [pat_reg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pincode] [varchar](20) NOT NULL,
   [date_created] [datetime] NOT NULL,
   [src_type] [smallint] NULL,
   [opt_out] [bit] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
