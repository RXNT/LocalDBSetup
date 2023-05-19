ALTER TABLE [dbo].[patient_login] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[patient_login] ADD CONSTRAINT [DF__patient_l__signa__1365B5CB] DEFAULT ('') FOR [signature]
GO
ALTER TABLE [dbo].[patient_login] ADD CONSTRAINT [DF__patient_l__passw__154DFE3D] DEFAULT ('1.0') FOR [passwordversion]
GO
ALTER TABLE [dbo].[patient_login] ADD  DEFAULT (NULL) FOR [inactivated_by]
GO
ALTER TABLE [dbo].[patient_login] ADD  DEFAULT (NULL) FOR [inactivated_date]
GO
