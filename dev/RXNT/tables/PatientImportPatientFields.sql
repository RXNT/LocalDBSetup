CREATE TABLE [dbo].[PatientImportPatientFields] (
   [PIFieldID] [int] NOT NULL
      IDENTITY (1,1),
   [PIFieldNameInPatientsTable] [varchar](100) NULL,
   [PIFieldSortOrder] [int] NULL,
   [PIFieldFriendlyName] [varchar](200) NULL,
   [PIFieldRequired] [bit] NULL

   ,CONSTRAINT [PK_PatientImportPatientFields] PRIMARY KEY CLUSTERED ([PIFieldID])
)


GO
