ALTER TABLE [dbo].[patient_procedures] ADD CONSTRAINT [DF__patient_p__recor__13C96F67] DEFAULT (getdate()) FOR [record_modified_date]
GO
