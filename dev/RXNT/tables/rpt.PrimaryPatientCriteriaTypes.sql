CREATE TABLE [rpt].[PrimaryPatientCriteriaTypes] (
   [PrimaryPatientCriteriaTypeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](1000) NOT NULL,
   [Description] [varchar](5000) NOT NULL,
   [Weightage] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_PrimaryPatientCriteriaTypes_Code] UNIQUE NONCLUSTERED ([Code])
   ,CONSTRAINT [PK_PrimaryPatientCriteriaTypes] PRIMARY KEY CLUSTERED ([PrimaryPatientCriteriaTypeId])
)


GO
