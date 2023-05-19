ALTER TABLE [dbo].[PrinterMaster] ADD CONSTRAINT [DF_PrinterMaster_is_activated] DEFAULT ((1)) FOR [is_activated]
GO
