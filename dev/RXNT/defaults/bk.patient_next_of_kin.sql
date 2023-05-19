ALTER TABLE [bk].[patient_next_of_kin] ADD CONSTRAINT [DF__patient_n__creat__75AFC7F2] DEFAULT (getdate()) FOR [created_date]
GO
