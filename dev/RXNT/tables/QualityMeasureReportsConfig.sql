CREATE TABLE [dbo].[QualityMeasureReportsConfig] (
   [qmr_id] [int] NOT NULL
      IDENTITY (1,1),
   [version] [varchar](5) NULL,
   [reporting_years] [varchar](200) NULL

   ,CONSTRAINT [PK__QualityM__687C310459888A90] PRIMARY KEY CLUSTERED ([qmr_id])
)


GO
