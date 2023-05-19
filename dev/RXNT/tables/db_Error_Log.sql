CREATE TABLE [dbo].[db_Error_Log] (
   [err_id] [int] NOT NULL
      IDENTITY (1,1),
   [error_code] [int] NOT NULL,
   [error_desc] [varchar](1024) NULL,
   [error_time] [smalldatetime] NOT NULL,
   [application] [varchar](50) NOT NULL,
   [method] [varchar](255) NULL,
   [COMMENTS] [text] NULL,
   [errorline] [int] NULL

   ,CONSTRAINT [PK_db_Error_Log] PRIMARY KEY CLUSTERED ([err_id])
)


GO
