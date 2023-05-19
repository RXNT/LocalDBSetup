ALTER TABLE [dbo].[printer_registration] WITH CHECK ADD CONSTRAINT [FK__printer_r__pm_id__60882BD5]
   FOREIGN KEY([pm_id]) REFERENCES [dbo].[PrinterMaster] ([pm_id])

GO
