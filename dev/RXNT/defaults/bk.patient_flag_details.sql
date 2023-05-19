ALTER TABLE [bk].[patient_flag_details] ADD CONSTRAINT [DF__patient_f__creat__04F20B82] DEFAULT (getdate()) FOR [created_date]
GO
