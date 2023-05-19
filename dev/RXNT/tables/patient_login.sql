CREATE TABLE [dbo].[patient_login] (
   [pa_id] [int] NOT NULL,
   [pa_username] [varchar](30) NOT NULL,
   [pa_password] [varchar](100) NOT NULL,
   [pa_email] [varchar](100) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [salt] [varchar](20) NOT NULL,
   [enabled] [bit] NOT NULL,
   [cellphone] [varchar](20) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [signature] [varchar](500) NOT NULL,
   [passwordversion] [varchar](10) NOT NULL,
   [pa_login_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [WeavyId] [int] NULL,
   [accepted_terms_date] [datetime] NULL,
   [inactivated_by] [int] NULL,
   [inactivated_date] [datetime] NULL

   ,CONSTRAINT [PK_patient_login] PRIMARY KEY CLUSTERED ([pa_username])
)

CREATE NONCLUSTERED INDEX [IX_patient_login] ON [dbo].[patient_login] ([pa_id], [pa_username], [pa_password])

GO
