CREATE TABLE [dbo].[ASP_Error_Log] (
   [err_id] [int] NOT NULL
      IDENTITY (1,1),
   [error_code] [int] NOT NULL,
   [error_desc] [varchar](1024) NULL,
   [error_time] [datetime] NOT NULL,
   [application] [varchar](50) NOT NULL,
   [method] [varchar](2048) NULL,
   [comments] [text] NULL

   ,CONSTRAINT [PK_ASP_Error_Log] PRIMARY KEY CLUSTERED ([err_id])
)


GO
