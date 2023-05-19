ALTER TABLE [dbo].[lab_result_details] WITH CHECK ADD CONSTRAINT [FK_lab_result_details_lab_result_info]
   FOREIGN KEY([lab_result_info_id]) REFERENCES [dbo].[lab_result_info] ([lab_result_info_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
