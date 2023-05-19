CREATE TABLE [dbo].[patients_medcare_coverage] (
   [pa_medcare_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [CONTRACT_ID] [varchar](10) NOT NULL,
   [PLAN_ID] [varchar](5) NOT NULL,
   [SEGMENT_ID] [varchar](5) NOT NULL,
   [PLAN_NAME] [varchar](50) NOT NULL,
   [FORMULARY_ID] [varchar](10) NOT NULL,
   [MA_REGION_CODE] [varchar](5) NOT NULL,
   [PDP_REGION_CODE] [varchar](5) NOT NULL,
   [State] [varchar](2) NOT NULL

   ,CONSTRAINT [PK_patients_medcare_coverage] PRIMARY KEY NONCLUSTERED ([pa_id])
)


GO
