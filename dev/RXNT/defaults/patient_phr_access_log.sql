ALTER TABLE [dbo].[patient_phr_access_log] ADD  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[patient_phr_access_log] ADD  DEFAULT (NULL) FOR [phr_access_datetime_utc]
GO
