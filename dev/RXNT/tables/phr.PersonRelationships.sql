CREATE TABLE [phr].[PersonRelationships] (
   [PersonRelationshipId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](250) NOT NULL,
   [Description] [varchar](500) NOT NULL,
   [SortOrder] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_PersonRelationships] PRIMARY KEY CLUSTERED ([PersonRelationshipId])
)


GO
