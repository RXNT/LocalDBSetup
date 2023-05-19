ALTER TABLE [spe].[SPEMessages] WITH CHECK ADD CONSTRAINT [FK_SPEMessages_prescription_details]
   FOREIGN KEY([pd_id]) REFERENCES [dbo].[prescription_details] ([pd_id])

GO
ALTER TABLE [spe].[SPEMessages] WITH CHECK ADD CONSTRAINT [FK_SPEMessages_prescriptions]
   FOREIGN KEY([pres_id]) REFERENCES [dbo].[prescriptions] ([pres_id])

GO
