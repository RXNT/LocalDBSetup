ALTER TABLE [dbo].[prescription_sendws_log] ADD CONSTRAINT [DF_prescription_sendws_log_entry_date] DEFAULT (getdate()) FOR [entry_date]
GO
