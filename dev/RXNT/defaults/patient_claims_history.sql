ALTER TABLE [dbo].[patient_claims_history] ADD CONSTRAINT [DF_patient_claims_history_claim_download_date] DEFAULT (getdate()) FOR [claim_download_date]
GO
ALTER TABLE [dbo].[patient_claims_history] ADD CONSTRAINT [DF_patient_claims_history_ddid] DEFAULT ((0)) FOR [ddid]
GO
ALTER TABLE [dbo].[patient_claims_history] ADD CONSTRAINT [DF_patient_claims_history_ndc] DEFAULT ('') FOR [ndc]
GO
ALTER TABLE [dbo].[patient_claims_history] ADD  DEFAULT ('') FOR [comments]
GO
