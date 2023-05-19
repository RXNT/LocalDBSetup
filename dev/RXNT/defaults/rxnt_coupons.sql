ALTER TABLE [dbo].[rxnt_coupons] ADD CONSTRAINT [DF_rxnt_coupons_is_complete] DEFAULT ((0)) FOR [is_complete]
GO
ALTER TABLE [dbo].[rxnt_coupons] ADD CONSTRAINT [DF__rxnt_coup__is_ph__5A7BE372] DEFAULT ((0)) FOR [is_pharm_comment]
GO
ALTER TABLE [dbo].[rxnt_coupons] ADD CONSTRAINT [DF__rxnt_coup__is_ne__5C642BE4] DEFAULT ((0)) FOR [is_new_pat]
GO
