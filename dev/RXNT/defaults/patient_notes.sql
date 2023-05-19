ALTER TABLE [dbo].[patient_notes] ADD CONSTRAINT [DF_patient_notes_note_date] DEFAULT (getdate()) FOR [note_date]
GO
ALTER TABLE [dbo].[patient_notes] ADD CONSTRAINT [DF_patient_notes_void] DEFAULT (0) FOR [void]
GO
ALTER TABLE [dbo].[patient_notes] ADD  DEFAULT ((0)) FOR [partner_id]
GO
