ALTER TABLE [dbo].[PatientImportFiles] ADD CONSTRAINT [DF_PatientImportFiles_PIFileImportComplete] DEFAULT ((0)) FOR [PIFileImportComplete]
GO
ALTER TABLE [dbo].[PatientImportFiles] ADD CONSTRAINT [DF_PatientImportFiles_PIFileUploadDateTime] DEFAULT (getdate()) FOR [PIFileUploadDateTime]
GO
ALTER TABLE [dbo].[PatientImportFiles] ADD CONSTRAINT [DF_PatientImportFiles_PIFileUserFieldMapIndexes] DEFAULT ('') FOR [PIFileUserFieldMapIndexes]
GO
