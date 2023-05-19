CREATE TABLE [dbo].[PatientImportFiles] (
   [PIFileID] [int] NOT NULL
      IDENTITY (1,1),
   [PIFileExtension] [varchar](10) NOT NULL,
   [PIFileDelimiter] [varchar](10) NOT NULL,
   [PIFileUserID] [varchar](50) NOT NULL,
   [PIFileImportComplete] [bit] NOT NULL,
   [PIFileUploadDateTime] [datetime] NOT NULL,
   [PIFileImportDateTime] [datetime] NULL,
   [PIFileFirstRowIsFieldNames] [bit] NOT NULL,
   [PIFileUserFieldMapIndexes] [varchar](200) NOT NULL

   ,CONSTRAINT [PK_PatientImportFiles] PRIMARY KEY CLUSTERED ([PIFileID])
)


GO
