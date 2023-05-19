ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_rxhub_part_id] DEFAULT ('               ') FOR [rxhub_part_id]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_pbm_name] DEFAULT ('') FOR [pbm_name]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_pbm_notes] DEFAULT ('') FOR [pbm_notes]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_disp_string] DEFAULT ('') FOR [disp_string]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_disp_options] DEFAULT ('') FOR [disp_options]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF__pbms__is_gcn_bas__59DE5BA2] DEFAULT ((0)) FOR [is_gcn_based_form]
GO
