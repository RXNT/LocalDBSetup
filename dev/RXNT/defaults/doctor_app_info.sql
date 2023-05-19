ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_app_i__PM__169198D0] DEFAULT ((0)) FOR [PM]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_app___EHR__1785BD09] DEFAULT ((0)) FOR [EHR]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_app___ERX__1879E142] DEFAULT ((0)) FOR [ERX]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_app__EPCS__196E057B] DEFAULT ((0)) FOR [EPCS]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_ap__SCHED__1A6229B4] DEFAULT ((0)) FOR [SCHEDULER]
GO
