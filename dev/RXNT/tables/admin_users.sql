CREATE TABLE [dbo].[admin_users] (
   [admin_id] [int] NOT NULL
      IDENTITY (1,1),
   [admin_company_id] [int] NULL,
   [admin_username] [varchar](50) NOT NULL,
   [admin_password] [varchar](50) NOT NULL,
   [admin_first_name] [varchar](50) NOT NULL,
   [admin_middle_initial] [varchar](2) NOT NULL,
   [admin_last_name] [varchar](50) NOT NULL,
   [enabled] [bit] NOT NULL,
   [admin_user_rights] [int] NOT NULL,
   [admin_user_create_date] [datetime] NOT NULL,
   [sales_person_id] [int] NOT NULL,
   [tracker_uid] [varchar](50) NOT NULL,
   [tracker_pwd] [varchar](50) NOT NULL,
   [is_token] [bit] NOT NULL

   ,CONSTRAINT [PK_admin_users] PRIMARY KEY NONCLUSTERED ([admin_id])
)


GO
