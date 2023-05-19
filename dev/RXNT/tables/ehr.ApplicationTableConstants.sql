CREATE TABLE [ehr].[ApplicationTableConstants] (
   [ApplicationTableConstantId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ApplicationTableId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [Description] [varchar](250) NOT NULL,
   [SortOrder] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_ApplicationTableConstants] PRIMARY KEY CLUSTERED ([ApplicationTableConstantId])
)


GO
