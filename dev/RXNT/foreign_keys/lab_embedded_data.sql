ALTER TABLE [dbo].[lab_embedded_data] WITH CHECK ADD CONSTRAINT [FK_lab_embedded_data_lab_result_details]
   FOREIGN KEY([lab_result_id]) REFERENCES [dbo].[lab_result_details] ([lab_result_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
