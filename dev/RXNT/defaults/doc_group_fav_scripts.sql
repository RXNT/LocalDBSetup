ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_script] DEFAULT (' ') FOR [dosage]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_use_generic] DEFAULT ((0)) FOR [use_generic]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_comments] DEFAULT (' ') FOR [comments]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_prn] DEFAULT ((0)) FOR [prn]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_as_directed] DEFAULT ((0)) FOR [as_directed]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_drug_version] DEFAULT ('FDB1.1') FOR [drug_version]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_prn_description] DEFAULT ('') FOR [prn_description]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF__doc_group__compo__4F8A1F0A] DEFAULT ((0)) FOR [compound]
GO
