CREATE TABLE [bk].[patient_registration] (
   [pa_reg_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [src_id] [smallint] NOT NULL,
   [pincode] [varchar](20) NOT NULL,
   [dr_id] [int] NOT NULL,
   [token] [varchar](30) NOT NULL,
   [reg_date] [smalldatetime] NOT NULL,
   [exp_date] [smalldatetime] NULL,
   [last_update_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
