CREATE TABLE [dbo].[patient_visit] (
   [visit_id] [int] NOT NULL
      IDENTITY (1,1),
   [appt_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dtCreate] [smalldatetime] NOT NULL,
   [dtEnd] [smalldatetime] NOT NULL,
   [enc_id] [int] NOT NULL,
   [chkout_notes] [varchar](max) NULL,
   [vital_id] [int] NULL,
   [reason] [varchar](255) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [clinical_notes] [varchar](max) NULL

   ,CONSTRAINT [PK_patient_visit] PRIMARY KEY CLUSTERED ([visit_id])
)

CREATE NONCLUSTERED INDEX [IDX_patient_visit_pa_id] ON [dbo].[patient_visit] ([pa_id])
CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[patient_visit] ([appt_id], [pa_id], [dr_id], [enc_id])

GO
