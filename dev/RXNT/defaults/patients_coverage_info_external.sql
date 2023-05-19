ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_ic_group_numb] DEFAULT (' ') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_card_holder_id] DEFAULT (' ') FOR [card_holder_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_card_holder_first] DEFAULT (' ') FOR [card_holder_first]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_card_holder_mi] DEFAULT (' ') FOR [card_holder_mi]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_card_holder_last] DEFAULT (' ') FOR [card_holder_last]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_ic_plan_numb] DEFAULT (' ') FOR [ic_plan_numb]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_ins_relate_code] DEFAULT (' ') FOR [ins_relate_code]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_ins_person_code] DEFAULT (' ') FOR [ins_person_code]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_formulary_id] DEFAULT (' ') FOR [formulary_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_alternative_id] DEFAULT (' ') FOR [alternative_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_pa_bin] DEFAULT (' ') FOR [pa_bin]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_pa_notes] DEFAULT (' ') FOR [pa_notes]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_def_ins_id] DEFAULT ((0)) FOR [def_ins_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_formulary_type] DEFAULT ((1)) FOR [formulary_type]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD  DEFAULT ('') FOR [copay_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD  DEFAULT ('') FOR [coverage_id]
GO
