CREATE TABLE [dbo].[pharmacy_users] (
   [pharm_user_id] [int] NOT NULL
      IDENTITY (1,1),
   [pharm_id] [int] NOT NULL,
   [pharm_user_prefix] [varchar](10) NOT NULL,
   [pharm_user_firstname] [varchar](50) NOT NULL,
   [pharm_user_mid_initial] [varchar](1) NOT NULL,
   [pharm_user_lastname] [varchar](50) NOT NULL,
   [pharm_user_suffix] [varchar](10) NOT NULL,
   [pharm_user_username] [varchar](20) NOT NULL,
   [pharm_user_password] [varchar](20) NOT NULL,
   [pharm_user_is_primary] [bit] NOT NULL,
   [pharm_user_time_difference] [int] NOT NULL,
   [pharm_user_agreement_acptd] [bit] NOT NULL,
   [pharm_user_hipaa_agreement_acptd] [bit] NOT NULL

   ,CONSTRAINT [PK_pharmacy_users] PRIMARY KEY CLUSTERED ([pharm_user_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [PUUserNameNoDupes] ON [dbo].[pharmacy_users] ([pharm_user_username])

GO
