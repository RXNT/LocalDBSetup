CREATE TABLE [bk].[patient_login] (
   [pa_id] [int] NOT NULL,
   [pa_username] [varchar](30) NOT NULL,
   [pa_password] [varchar](100) NOT NULL,
   [pa_email] [varchar](100) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [salt] [varchar](20) NOT NULL,
   [enabled] [bit] NOT NULL,
   [cellphone] [varchar](20) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
