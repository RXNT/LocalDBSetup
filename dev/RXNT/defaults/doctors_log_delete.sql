ALTER TABLE [dbo].[doctors_log_delete] ADD CONSTRAINT [DF_doctors_log_dc_id] DEFAULT ((0)) FOR [dr_field_not_used1]
GO
ALTER TABLE [dbo].[doctors_log_delete] ADD CONSTRAINT [DF_doctors_log_dr_first_name] DEFAULT ('') FOR [dr_first_name]
GO
ALTER TABLE [dbo].[doctors_log_delete] ADD CONSTRAINT [DF_doctors_log_dr_middle_initial] DEFAULT ('') FOR [dr_middle_initial]
GO
ALTER TABLE [dbo].[doctors_log_delete] ADD CONSTRAINT [DF_doctors_log_dr_last_name] DEFAULT ('') FOR [dr_last_name]
GO
