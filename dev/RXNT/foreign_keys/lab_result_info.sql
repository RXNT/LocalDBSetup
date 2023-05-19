ALTER TABLE [dbo].[lab_result_info] WITH CHECK ADD CONSTRAINT [FK_lab_result_info_lab_main]
   FOREIGN KEY([lab_id]) REFERENCES [dbo].[lab_main] ([lab_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[lab_result_info] WITH CHECK ADD CONSTRAINT [FK_lab_result_info_lab_order_info]
   FOREIGN KEY([lab_order_id]) REFERENCES [dbo].[lab_order_info] ([lab_report_id])

GO
