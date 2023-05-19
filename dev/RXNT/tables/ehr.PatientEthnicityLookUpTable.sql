CREATE TABLE [ehr].[PatientEthnicityLookUpTable] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [PARENT_ETHNICITY_ID] [varchar](20) NOT NULL,
   [ETHNICITY_ID] [varchar](20) NOT NULL

   ,CONSTRAINT [PK__PatientE__3214EC271A769EC0] PRIMARY KEY CLUSTERED ([ID])
)


GO
