CREATE TABLE [dbo].[MU4Measures] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [MeasureCode] [varchar](3) NOT NULL,
   [MeasureGroup] [varchar](3) NOT NULL,
   [MeasureName] [varchar](100) NOT NULL,
   [MeasureStage] [varchar](10) NOT NULL,
   [DisplayOrder] [int] NOT NULL,
   [MeasureDescription] [varchar](500) NULL,
   [PassingCriteria] [varchar](50) NULL,
   [IsActive] [bit] NOT NULL,
   [MeasureGroupName] [varchar](50) NULL,
   [PassingCriteriaMU2017] [varchar](50) NULL,
   [MeasureDescriptionMU2017] [varchar](max) NULL
)


GO
