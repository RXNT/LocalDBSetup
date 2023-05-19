ALTER TABLE [dbo].[table_audit_log] ADD CONSTRAINT [DF_table_audit_log_audit_id] DEFAULT (newid()) FOR [audit_id]
GO
