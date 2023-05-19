CREATE TABLE [dbo].[patient_phr_access_log] (
   [phr_access_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [bigint] NOT NULL,
   [phr_access_type] [int] NOT NULL,
   [phr_access_description] [varchar](1024) NOT NULL,
   [phr_access_datetime] [datetime] NULL,
   [phr_access_from_ip] [varchar](50) NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [PatientRepresentativeId] [bigint] NULL,
   [phr_access_datetime_utc] [datetime] NULL

   ,CONSTRAINT [PK_patient_phr_access_log] PRIMARY KEY CLUSTERED ([phr_access_log_id])
)


GO
