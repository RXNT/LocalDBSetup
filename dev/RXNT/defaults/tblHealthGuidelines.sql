ALTER TABLE [dbo].[tblHealthGuidelines] ADD CONSTRAINT [DF_tblHealthGuidelines_date_added] DEFAULT (getdate()) FOR [date_added]
GO
