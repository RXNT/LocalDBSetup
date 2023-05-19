CREATE TABLE [ehr].[PatientRaceLookUpTable] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [PARENT_RACE_ID] [varchar](20) NOT NULL,
   [RACE_ID] [varchar](20) NOT NULL

   ,CONSTRAINT [PK__PatientR__3214EC2714BDC56A] PRIMARY KEY CLUSTERED ([ID])
)


GO
