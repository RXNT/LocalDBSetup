ALTER TABLE [ehr].[ApplicationTableConstants] WITH CHECK ADD CONSTRAINT [FK_ApplicationTableConstants_ApplicationTables]
   FOREIGN KEY([ApplicationTableId]) REFERENCES [ehr].[ApplicationTables] ([ApplicationTableId])

GO
