CREATE TABLE [bk].[doctors_20161108] (
   [dr_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [dr_username] [varchar](50) NULL,
   [dr_password] [varchar](250) NULL,
   [salt] [varchar](250) NULL,
   [password_expiry_date] [smalldatetime] NULL
)


GO
