CREATE TABLE [dbo].[MIPSMeasures] (
   [Id] [bigint] NOT NULL
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
   [PassingCriteriaMIPS2017] [varchar](50) NULL,
   [MeasureDescription2017] [varchar](50) NULL,
   [MeasureClass] [varchar](100) NULL,
   [Performace_points_per_10_percent] [int] NULL,
   [MeasureCalculation] [varchar](100) NULL

   ,CONSTRAINT [PK_Id] PRIMARY KEY CLUSTERED ([Id])
)


GO
