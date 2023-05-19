ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_drug_name] DEFAULT (' ') FOR [drug_name]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_use_generic] DEFAULT (0) FOR [use_generic]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_numb_refills] DEFAULT (0) FOR [numb_refills]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_comments] DEFAULT (' ') FOR [comments]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_prn] DEFAULT (0) FOR [prn]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_as_directed] DEFAULT (0) FOR [as_directed]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_drug_version] DEFAULT ('FDB1.1') FOR [drug_version]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_history_enabled] DEFAULT (1) FOR [history_enabled]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_patient_delivery_method] DEFAULT (0) FOR [patient_delivery_method]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_vps_pres_id] DEFAULT ('') FOR [vps_pres_id]
GO
