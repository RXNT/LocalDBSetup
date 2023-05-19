ALTER TABLE [dbo].[rxnt_sg_promotions] ADD CONSTRAINT [DF__rxnt_sg_p__sessi__07C4568C] DEFAULT ((40541)) FOR [session_count]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD CONSTRAINT [DF__rxnt_sg_p__curre__09AC9EFE] DEFAULT ((0)) FOR [current_count]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((1)) FOR [type]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [speciality_1]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [speciality_2]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [speciality_3]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ('') FOR [url]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [clickthroughs]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [sponsor_id]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [increments]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD CONSTRAINT [DF__rxnt_sg_p__Activ__79B7C505] DEFAULT ((1)) FOR [Active]
GO
