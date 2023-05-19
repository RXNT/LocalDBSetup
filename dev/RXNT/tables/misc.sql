CREATE TABLE [dbo].[misc] (
   [db_ver] [int] NOT NULL,
   [city_ver] [int] NULL,
   [app_ver] [varchar](50) NOT NULL,
   [url] [varchar](250) NOT NULL,
   [fileName] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_misc] PRIMARY KEY CLUSTERED ([db_ver])
)


GO
