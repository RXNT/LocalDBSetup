ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_drug_name] DEFAULT (' ') FOR [drug_name]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_use_generic] DEFAULT ((0)) FOR [use_generic]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_numb_refills] DEFAULT ((0)) FOR [numb_refills]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_comments] DEFAULT (' ') FOR [comments]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_prn] DEFAULT ((0)) FOR [prn]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_as_directed] DEFAULT ((0)) FOR [as_directed]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_version] DEFAULT ('FDB1.1') FOR [drug_version]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_form_status] DEFAULT ((-1)) FOR [form_status]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_actual_form_status] DEFAULT ((-1)) FOR [actual_form_status]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_enabled] DEFAULT ((1)) FOR [history_enabled]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_patient_delivery_method] DEFAULT ((0)) FOR [patient_delivery_method]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_vps_pres_id] DEFAULT ('') FOR [vps_pres_id]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_include_in_print] DEFAULT ((1)) FOR [include_in_print]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_include_in_pharm_deliver] DEFAULT ((1)) FOR [include_in_pharm_deliver]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_prn_description] DEFAULT ('') FOR [prn_description]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF__prescript__compo__00A0C103] DEFAULT ((0)) FOR [compound]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF__prescripti__icd9__1E3123EA] DEFAULT ('') FOR [icd9]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF__prescript__is_specialty] DEFAULT (NULL) FOR [is_specialty]
GO
