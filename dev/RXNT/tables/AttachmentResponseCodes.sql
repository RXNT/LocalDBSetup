CREATE TABLE [dbo].[AttachmentResponseCodes] (
   [codeID] [nvarchar](10) NOT NULL,
   [codeSystemID] [nvarchar](10) NOT NULL,
   [description] [ntext] NULL,
   [sortKey] [nvarchar](50) NULL

   ,CONSTRAINT [PK_AttachmentResponseCodes] PRIMARY KEY CLUSTERED ([codeID])
)


GO
