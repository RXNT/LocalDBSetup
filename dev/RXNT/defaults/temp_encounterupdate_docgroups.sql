ALTER TABLE [dbo].[temp_encounterupdate_docgroups] ADD CONSTRAINT [DF_PerformedDate] DEFAULT (getdate()) FOR [PerformedDate]
GO
