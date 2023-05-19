CREATE TABLE [bk].[patient_social_hx] (
   [sochxid] [bigint] NOT NULL,
   [pat_id] [bigint] NULL,
   [emp_info] [varchar](max) NULL,
   [marital_status] [int] NULL,
   [other_marital_status] [varchar](255) NULL,
   [household_people_no] [varchar](50) NULL,
   [smoking_status] [int] NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bigint] NULL,
   [familyhx_other] [varchar](max) NULL,
   [medicalhx_other] [varchar](max) NULL,
   [surgeryhx_other] [varchar](max) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
