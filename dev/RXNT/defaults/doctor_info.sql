ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ('') FOR [dr_dea_first_name]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ('') FOR [dr_dea_last_name]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ('') FOR [dr_dea_middle_initial]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [blowusageemail]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((1)) FOR [is_custom_tester]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [is_epcs]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [settings]
GO
ALTER TABLE [dbo].[doctor_info] ADD CONSTRAINT [DF__doctor_in__Versi__61DDD96F] DEFAULT ('ehrv8') FOR [VersionURL]
GO
ALTER TABLE [dbo].[doctor_info] ADD CONSTRAINT [DF__doctor_in__bOver__161275E3] DEFAULT ((0)) FOR [bOverrideDEA]
GO
ALTER TABLE [dbo].[doctor_info] ADD CONSTRAINT [DF_doctor_info_encounter_version] DEFAULT ('v1.1') FOR [encounter_version]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [is_institutional_dea]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [hide_encounter_sign_confirmation_popup]
GO
ALTER TABLE [dbo].[doctor_info] ADD CONSTRAINT [DF_doctor_info_dont_ignore_popup_on_doctor_sign_encounter] DEFAULT ((0)) FOR [dont_ignore_popup_on_doctor_sign_encounter]
GO
