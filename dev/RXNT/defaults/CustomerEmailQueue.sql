ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_EmpID] DEFAULT ((0)) FOR [EmpID]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_OrderID] DEFAULT ((0)) FOR [OrderID]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_bSendSuccess] DEFAULT ((0)) FOR [bSendAttempted]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_bSMTPSVGFailed] DEFAULT ((0)) FOR [bSMTPSVGFailed]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strLastSMTPError] DEFAULT ('') FOR [strSMTPSVGErrorMsg]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strMDFailedAddress] DEFAULT ('') FOR [strMDFailedAddress]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strSubject] DEFAULT ('') FOR [strSubject]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strMDSessionTranscript] DEFAULT ('') FOR [strMDSessionTranscript]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strBody] DEFAULT ('') FOR [strBody]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_lngMasterOrderID] DEFAULT ((0)) FOR [lngMasterOrderID]
GO
