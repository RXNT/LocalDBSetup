ALTER TABLE [dbo].[lab_main] ADD CONSTRAINT [DF_lab_main_is_read] DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[lab_main] ADD CONSTRAINT [DF__lab_main__PROV_N__5230B634] DEFAULT ('') FOR [PROV_NAME]
GO
ALTER TABLE [dbo].[lab_main] ADD CONSTRAINT [DF__lab_main__type__3CAC54C0] DEFAULT ('Lab') FOR [type]
GO
