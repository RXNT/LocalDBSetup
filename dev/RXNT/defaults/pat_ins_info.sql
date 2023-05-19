ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_rxhub_pmb_id] DEFAULT ('') FOR [rxhub_pmb_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_ic_group_numb] DEFAULT ('') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_ic_plan_numb] DEFAULT ('') FOR [ic_plan_numb]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_formulary_id] DEFAULT ('') FOR [formulary_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_alternative_id] DEFAULT ('') FOR [alternative_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_pbm_member_id] DEFAULT ('') FOR [pbm_member_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_pa_bin] DEFAULT ('') FOR [pa_bin]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_ins_relate_code] DEFAULT (21) FOR [ins_relate_code]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_ins_person_code] DEFAULT ('') FOR [ins_person_code]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_card_holder_id] DEFAULT ('') FOR [card_holder_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_card_holder_first] DEFAULT ('') FOR [card_holder_first]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_card_holder_middle] DEFAULT ('') FOR [card_holder_middle]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_card_holder_last] DEFAULT ('') FOR [card_holder_last]
GO
