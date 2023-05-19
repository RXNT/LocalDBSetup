CREATE TABLE [dbo].[FileInfo] (
   [FileId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Name] [varchar](100) NULL,
   [Base64Content] [varchar](max) NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [datetime] NULL

   ,CONSTRAINT [PK_FileInfo] PRIMARY KEY CLUSTERED ([FileId])
)


GO
