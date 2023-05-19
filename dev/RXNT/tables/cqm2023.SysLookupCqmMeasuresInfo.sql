CREATE TABLE [cqm2023].[SysLookupCqmMeasuresInfo] (
   [MeasureInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureTitle] [varchar](max) NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [Description] [varchar](max) NOT NULL,
   [MeasureNumber] [varchar](max) NOT NULL,
   [NQFNumber] [varchar](max) NOT NULL,
   [SetId] [varchar](50) NULL

   ,CONSTRAINT [PK_CqmMeasures] PRIMARY KEY CLUSTERED ([MeasureInfoId])
)


GO
