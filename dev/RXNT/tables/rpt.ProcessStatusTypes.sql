CREATE TABLE [rpt].[ProcessStatusTypes] (
   [ProcessStatusTypeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](100) NOT NULL,
   [Description] [varchar](500) NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_ProcessStatusTypes_Code] UNIQUE NONCLUSTERED ([Code])
   ,CONSTRAINT [PK_ProcessStatusTypes] PRIMARY KEY CLUSTERED ([ProcessStatusTypeId])
)


GO
