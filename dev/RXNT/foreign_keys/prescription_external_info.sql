ALTER TABLE [dbo].[prescription_external_info] WITH CHECK ADD CONSTRAINT [FK_prescription_external_info_prescription_details]
   FOREIGN KEY([pd_id]) REFERENCES [dbo].[prescription_details] ([pd_id])

GO
ALTER TABLE [dbo].[prescription_external_info] WITH CHECK ADD CONSTRAINT [FK_prescription_external_info_prescriptions]
   FOREIGN KEY([pres_id]) REFERENCES [dbo].[prescriptions] ([pres_id])

GO
