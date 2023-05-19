ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ('') FOR [uid]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ('') FOR [pwd]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ((0)) FOR [allergy_upload]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ((0)) FOR [diagnosis_upload]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ((0)) FOR [sched_upload]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD CONSTRAINT [DF_hl7_cross_reference_chart_no] DEFAULT ((0)) FOR [chart_no]
GO
