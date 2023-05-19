ALTER TABLE [dbo].[prescription_pharm_actions] ADD CONSTRAINT [DF_prescription_pharm_actions_action_date] DEFAULT (getdate()) FOR [action_date]
GO
ALTER TABLE [dbo].[prescription_pharm_actions] ADD CONSTRAINT [DF_prescription_pharm_actions_detail_text] DEFAULT ('') FOR [detail_text]
GO
