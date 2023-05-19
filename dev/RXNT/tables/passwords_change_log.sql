CREATE TABLE [dbo].[passwords_change_log] (
   [pcl_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dr_password] [varchar](50) NOT NULL,
   [password_create_date] [smalldatetime] NOT NULL,
   [password_ascii_strength] [int] NOT NULL,
   [user_type] [int] NOT NULL

   ,CONSTRAINT [PK_passwords_change_log] PRIMARY KEY CLUSTERED ([pcl_id])
)


GO
