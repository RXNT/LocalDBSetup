ALTER TABLE [dbo].[lab_result_specimen] WITH CHECK ADD CONSTRAINT [FK__lab_resul__lab_i__5C39435B]
   FOREIGN KEY([lab_id]) REFERENCES [dbo].[lab_main] ([lab_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
