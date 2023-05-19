ALTER TABLE [dbo].[lab_main] WITH CHECK ADD CONSTRAINT [FKLabMainInformationBlockingReason]
   FOREIGN KEY([InformationBlockingReasonId]) REFERENCES [dbo].[InformationBlockingReason] ([Id])

GO
