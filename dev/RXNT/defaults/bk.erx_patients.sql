ALTER TABLE [bk].[erx_patients] ADD CONSTRAINT [DF__erx_patie__creat__1DBDB94C] DEFAULT (getdate()) FOR [created_date]
GO
