ALTER TABLE [dbo].[RefTracking] ADD CONSTRAINT [DF_RefTracking_DT] DEFAULT (getdate()) FOR [DT]
GO
