ALTER TABLE [dbo].[refill_requests] ADD CONSTRAINT [DF_refill_requests_msg_ref_number] DEFAULT ('') FOR [msg_ref_number]
GO
ALTER TABLE [dbo].[refill_requests] ADD CONSTRAINT [DF__refill_re__disp___0B1E4F76] DEFAULT ((0)) FOR [disp_drug_info]
GO
