ALTER TABLE [dbo].[sponsors] ADD CONSTRAINT [DF_sponsors1_sponsor_name] DEFAULT ('') FOR [sponsor_name]
GO
ALTER TABLE [dbo].[sponsors] ADD CONSTRAINT [DF_sponsors1_sponsor_lbl] DEFAULT ('') FOR [sponsor_lbl]
GO
ALTER TABLE [dbo].[sponsors] ADD CONSTRAINT [DF_sponsors_sponsor_type_id] DEFAULT (0) FOR [sponsor_type_id]
GO
ALTER TABLE [dbo].[sponsors] ADD CONSTRAINT [DF_sponsors_sponsor_msg] DEFAULT ('') FOR [sponsor_msg]
GO
