ALTER TABLE [dbo].[doctor_patient_messages] ADD CONSTRAINT [DF_doctor_pa_msg_date] DEFAULT (NULL) FOR [msg_date]
GO
ALTER TABLE [dbo].[doctor_patient_messages] ADD CONSTRAINT [DF__doctor_pa__is_re__6F6CDEB7] DEFAULT ((0)) FOR [is_read]
GO
