CREATE TABLE [ehr].[SysLookupCodes] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CodeSystemId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NOT NULL,
   [Active] [bit] NOT NULL,
   [ApplicationTableConstantCode] [varchar](200) NULL,
   [ApplicationTableConstantId] [bigint] NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C155805C432] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
