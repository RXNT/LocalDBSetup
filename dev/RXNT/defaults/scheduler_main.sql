ALTER TABLE [dbo].[scheduler_main] ADD CONSTRAINT [DF__scheduler__ext_l__0D6FE0E5] DEFAULT ((0)) FOR [ext_link_id]
GO
ALTER TABLE [dbo].[scheduler_main] ADD CONSTRAINT [DF__scheduler___note__0E64051E] DEFAULT ('') FOR [note]
GO
ALTER TABLE [dbo].[scheduler_main] ADD CONSTRAINT [DF__scheduler__detai__0F582957] DEFAULT ('') FOR [detail_header]
GO
ALTER TABLE [dbo].[scheduler_main] ADD  DEFAULT ((0)) FOR [is_new_pat]
GO
ALTER TABLE [dbo].[scheduler_main] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[scheduler_main] ADD  DEFAULT ((0)) FOR [is_confirmed]
GO
ALTER TABLE [dbo].[scheduler_main] ADD CONSTRAINT [DF__scheduler__is_de__65E3747D] DEFAULT ((0)) FOR [is_delete_attempt]
GO
