ALTER TABLE [dbo].[patients] WITH CHECK ADD CONSTRAINT [FkPatientsInformationBlockingReason]
   FOREIGN KEY([InformationBlockingReasonId]) REFERENCES [dbo].[InformationBlockingReason] ([Id])

GO
