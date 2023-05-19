CREATE TABLE [dbo].[rxnt_coupon_users] (
   [user_id] [int] NOT NULL
      IDENTITY (1,1),
   [first_name] [varchar](50) NOT NULL,
   [middle_name] [varchar](10) NOT NULL,
   [last_name] [varchar](50) NOT NULL,
   [email] [varchar](50) NOT NULL,
   [phone] [varchar](12) NOT NULL,
   [username] [varchar](25) NOT NULL,
   [password] [varchar](512) NOT NULL,
   [salt] [varchar](50) NOT NULL,
   [is_enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_rxnt_coupon_users] PRIMARY KEY CLUSTERED ([user_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_rxnt_coupon_users] ON [dbo].[rxnt_coupon_users] ([username])

GO
