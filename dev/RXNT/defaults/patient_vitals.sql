ALTER TABLE [dbo].[patient_vitals] ADD  DEFAULT ((0)) FOR [pa_oxm]
GO
ALTER TABLE [dbo].[patient_vitals] ADD  DEFAULT (getdate()) FOR [record_modified_date]
GO
ALTER TABLE [dbo].[patient_vitals] ADD  DEFAULT ((0)) FOR [pa_hc]
GO
