ALTER TABLE [dbo].[patient_menu_doctor_level] WITH CHECK ADD CONSTRAINT [FK_patient_menu_doctor_level_doc_companies]
   FOREIGN KEY([dc_id]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [dbo].[patient_menu_doctor_level] WITH CHECK ADD CONSTRAINT [FK_patient_menu_doctor_level_master_patient_menu]
   FOREIGN KEY([master_patient_menu_id]) REFERENCES [dbo].[master_patient_menu] ([master_patient_menu_id])

GO
