ALTER TABLE [dbo].[prescription_coverage_info] ADD CONSTRAINT [DF__prescript__ic_gr__25676607] DEFAULT ('') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[prescription_coverage_info] ADD CONSTRAINT [DF__prescript__formu__265B8A40] DEFAULT ('0') FOR [formulary_id]
GO
ALTER TABLE [dbo].[prescription_coverage_info] ADD CONSTRAINT [DF__prescript__formu__274FAE79] DEFAULT ((0)) FOR [formulary_type]
GO
