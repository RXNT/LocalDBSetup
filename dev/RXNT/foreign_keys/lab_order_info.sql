ALTER TABLE [dbo].[lab_order_info] WITH CHECK ADD CONSTRAINT [FK_lab_order_info_lab_main]
   FOREIGN KEY([lab_id]) REFERENCES [dbo].[lab_main] ([lab_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
