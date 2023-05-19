ALTER TABLE [dbo].[scheduled_rx_archive] ADD CONSTRAINT [DF_scheduled_rx_archive_signature_version] DEFAULT ('V1') FOR [signature_version]
GO
