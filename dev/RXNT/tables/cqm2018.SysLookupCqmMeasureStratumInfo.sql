CREATE TABLE [cqm2018].[SysLookupCqmMeasureStratumInfo] (
   [StratumInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationInfoId] [bigint] NOT NULL,
   [StratumIndex] [int] NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasureStratums] PRIMARY KEY CLUSTERED ([StratumInfoId])
)


GO
