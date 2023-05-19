ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF_ScriptGuideProgramSpecifications_trigger_type] DEFAULT ((1)) FOR [trigger_type]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF__ScriptGui__test___41E4747B] DEFAULT ((0)) FOR [test_count]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF__ScriptGui__contr__42D898B4] DEFAULT ((0)) FOR [control_count]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF_ScriptGuideProgramSpecifications_sg_desc_text] DEFAULT ('') FOR [sg_desc_text]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF_ScriptGuideProgramSpecifications_bRequireCoupon] DEFAULT ((0)) FOR [bRequireCoupon]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF_ScriptGuideProgramSpecifications_bIsActive] DEFAULT ((0)) FOR [bIsActive]
GO
