ALTER TABLE [dbo].[lab_test_lists] ADD CONSTRAINT [DF_lab_test_lists_active] DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[lab_test_lists] ADD CONSTRAINT [DF__lab_test___test___607ED58B] DEFAULT ((1)) FOR [test_type]
GO
ALTER TABLE [dbo].[lab_test_lists] ADD CONSTRAINT [DF__lab_test___CODE___226272D8] DEFAULT ('LOINC') FOR [CODE_TYPE]
GO
