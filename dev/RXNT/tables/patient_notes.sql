CREATE TABLE [dbo].[patient_notes] (
   [note_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [note_date] [datetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [void] [bit] NOT NULL,
   [note_text] [varchar](5000) NOT NULL,
   [partner_id] [tinyint] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [note_html] [varchar](max) NULL

   ,CONSTRAINT [PK_patient_notes] PRIMARY KEY CLUSTERED ([note_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_notes-pa_id-void] ON [dbo].[patient_notes] ([pa_id], [void])

GO
