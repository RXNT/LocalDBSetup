ALTER TABLE [dbo].[lab_pat_details] WITH CHECK ADD CONSTRAINT [FK_lab_pat_details_lab_main]
   FOREIGN KEY([lab_id]) REFERENCES [dbo].[lab_main] ([lab_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
