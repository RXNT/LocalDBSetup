ALTER TABLE [dbo].[tblVaccines] ADD CONSTRAINT [DF__tblVaccin__dc_id__7D9A3726] DEFAULT ((0)) FOR [dc_id]
GO
ALTER TABLE [dbo].[tblVaccines] ADD CONSTRAINT [DF__tblVaccin__vac_e__7E8E5B5F] DEFAULT ('99') FOR [vac_exp_code]
GO
ALTER TABLE [dbo].[tblVaccines] ADD CONSTRAINT [DF__tblVaccin__CVX_C__27114E05] DEFAULT ('') FOR [CVX_CODE]
GO
ALTER TABLE [dbo].[tblVaccines] ADD CONSTRAINT [DF__tblVaccin__mvx_c__28F99677] DEFAULT ('') FOR [mvx_code]
GO
