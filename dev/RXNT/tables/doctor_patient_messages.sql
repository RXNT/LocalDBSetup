CREATE TABLE [dbo].[doctor_patient_messages] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [from_id] [int] NOT NULL,
   [to_id] [int] NOT NULL,
   [msg_date] [datetime] NOT NULL,
   [message] [text] NOT NULL,
   [is_read] [bit] NOT NULL,
   [is_complete] [bit] NULL,
   [from_deleted_id] [int] NULL,
   [to_deleted_id] [int] NULL,
   [messagedigest] [varchar](2000) NULL,
   [PatientRepresentativeId] [bigint] NULL,
   [msg_date_utc] [datetime] NULL

   ,CONSTRAINT [PK_doctor_patient_messages] PRIMARY KEY CLUSTERED ([id])
)

CREATE NONCLUSTERED INDEX [ix_doctor_patient_messages_to_id_is_complete_to_deleted_id] ON [dbo].[doctor_patient_messages] ([to_id], [is_complete], [to_deleted_id])

GO
