CREATE TABLE [dbo].[State] (
   [state_code] [varchar](10) NOT NULL,
   [state] [varchar](50) NOT NULL,
   [created_date] [datetime] NULL,
   [created_user] [varchar](50) NULL,
   [modified_date] [datetime] NULL,
   [modified_user] [varchar](50) NULL,
   [time_zone] [varchar](5) NULL,
   [time_difference] [tinyint] NULL
)


GO
