ALTER TABLE [dbo].[prescription_taper_info] WITH CHECK ADD CONSTRAINT [FK_prescription_taper_info_prescription_details]
   FOREIGN KEY([pd_id]) REFERENCES [dbo].[prescription_details] ([pd_id])

GO
