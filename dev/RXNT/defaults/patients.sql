ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_dg_id] DEFAULT (0) FOR [dg_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_dr_id] DEFAULT (0) FOR [dr_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_first] DEFAULT (' ') FOR [pa_first]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_middle] DEFAULT (' ') FOR [pa_middle]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_last] DEFAULT (' ') FOR [pa_last]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_ssn] DEFAULT (' ') FOR [pa_ssn]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_address1] DEFAULT (' ') FOR [pa_address1]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_address2] DEFAULT (' ') FOR [pa_address2]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_city] DEFAULT (' ') FOR [pa_city]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_state] DEFAULT (' ') FOR [pa_state]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_zip] DEFAULT (' ') FOR [pa_zip]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_phone] DEFAULT (' ') FOR [pa_phone]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_wgt] DEFAULT (0) FOR [pa_wgt]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_sex] DEFAULT (' ') FOR [pa_sex]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ic_id] DEFAULT (0) FOR [ic_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ic_group_numb] DEFAULT (' ') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_card_holder_id] DEFAULT (' ') FOR [card_holder_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_card_holder_first] DEFAULT (' ') FOR [card_holder_first]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_card_holder_mi] DEFAULT (' ') FOR [card_holder_mi]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_card_holder_last] DEFAULT (' ') FOR [card_holder_last]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ins_pat_numb] DEFAULT (' ') FOR [ic_plan_numb]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ins_relate_code] DEFAULT (' ') FOR [ins_relate_code]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ins_person_code] DEFAULT (' ') FOR [ins_person_code]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_formulary_id] DEFAULT (' ') FOR [formulary_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_alternative_id] DEFAULT (' ') FOR [alternative_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_bin] DEFAULT (' ') FOR [pa_bin]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_primary_pharm_id] DEFAULT (0) FOR [primary_pharm_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_notes] DEFAULT (' ') FOR [pa_notes]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_def_ins_id] DEFAULT (0) FOR [def_ins_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_last_check_date] DEFAULT (1 / 1 / 2000) FOR [last_check_date]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_check_eligibility] DEFAULT (0) FOR [check_eligibility]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF__patients__sfi_is__046664EF] DEFAULT (0) FOR [sfi_is_sfi]
GO
ALTER TABLE [dbo].[patients] ADD  DEFAULT (0) FOR [pa_ht]
GO
ALTER TABLE [dbo].[patients] ADD  DEFAULT (getdate()) FOR [add_date]
GO
ALTER TABLE [dbo].[patients] ADD  DEFAULT (getdate()) FOR [record_modified_date]
GO
