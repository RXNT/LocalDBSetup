ALTER TABLE [bk].[patient_hm_alerts] ADD CONSTRAINT [DF__patient_h__creat__0309C310] DEFAULT (getdate()) FOR [created_date]
GO
