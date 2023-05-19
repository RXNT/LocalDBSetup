ALTER TABLE [dbo].[doc_group_freetext_med_ingredients] ADD CONSTRAINT [DF_doc_group_freetext_med_ingredients_is_active] DEFAULT ((1)) FOR [is_active]
GO
