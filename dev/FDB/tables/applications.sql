CREATE TABLE [dbo].[applications] (
   [app_id] [int] NOT NULL,
   [app_name] [varchar](50) NOT NULL,
   [app_base_url] [varchar](255) NOT NULL,
   [app_main_database] [varchar](50) NOT NULL,
   [app_formularies_database] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_applications] PRIMARY KEY CLUSTERED ([app_id])
)


GO
