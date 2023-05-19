ALTER TABLE [dbo].[erx_patients] ADD CONSTRAINT [DF_erx_patients_dc_id] DEFAULT (0) FOR [dc_id]
GO
ALTER TABLE [dbo].[erx_patients] ADD CONSTRAINT [DF_erx_patients_pa_sex] DEFAULT ('U') FOR [pa_sex]
GO
ALTER TABLE [dbo].[erx_patients] ADD CONSTRAINT [DF_erx_patients_pa_address1] DEFAULT ('') FOR [pa_address1]
GO
ALTER TABLE [dbo].[erx_patients] ADD CONSTRAINT [DF_erx_patients_pa_address2] DEFAULT ('') FOR [pa_address2]
GO
