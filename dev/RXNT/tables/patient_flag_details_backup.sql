CREATE TABLE [dbo].[patient_flag_details_backup] (
   [pa_flag_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [flag_id] [int] NOT NULL,
   [flag_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL
)


GO
