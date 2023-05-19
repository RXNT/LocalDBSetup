CREATE TABLE [cqm2023].[SysLookupCqmMeasurePopulationInfo] (
   [PopulationInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationIndex] [bigint] NOT NULL,
   [HasDenomException] [bit] NOT NULL,
   [HasDenomExclusion] [bit] NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
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

   ,CONSTRAINT [PK_CqmMeasurePopCriteria] PRIMARY KEY CLUSTERED ([PopulationInfoId])
)


GO
