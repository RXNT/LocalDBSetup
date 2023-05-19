ALTER TABLE [dbo].[tblSubHealthGuidelines] WITH CHECK ADD CONSTRAINT [FK_tblSubHealthGuidelines_tblHealthGuidelines]
   FOREIGN KEY([rule_id]) REFERENCES [dbo].[tblHealthGuidelines] ([rule_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
