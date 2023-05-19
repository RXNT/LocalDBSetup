ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_stage] DEFAULT ((0)) FOR [stage]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_comments] DEFAULT ('') FOR [comments]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_ups_tracking_id] DEFAULT ('') FOR [ups_tracking_id]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_ups_label_file] DEFAULT ('') FOR [ups_label_file]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_fee] DEFAULT ((0)) FOR [shipping_fee]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_address1] DEFAULT ('') FOR [shipping_address1]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_city] DEFAULT ('') FOR [shipping_city]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_state] DEFAULT ('XX') FOR [shipping_state]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_zip] DEFAULT ('') FOR [shipping_zip]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF__doc_token__email__7450C40E] DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF__doc_token__idret__0F04BA4A] DEFAULT ((0)) FOR [idretries]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF__doc_token__maxid__0FF8DE83] DEFAULT ((0)) FOR [maxidretries]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF__doc_token__IsSig__7B5E7FA7] DEFAULT ((0)) FOR [IsSigRequired]
GO
