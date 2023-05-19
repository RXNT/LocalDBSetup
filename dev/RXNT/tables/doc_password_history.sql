CREATE TABLE [dbo].[doc_password_history] (
   [change_pwd_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [password1] [varchar](50) NOT NULL,
   [password2] [varchar](50) NOT NULL,
   [password3] [varchar](50) NOT NULL,
   [nowactive] [smallint] NOT NULL

   ,CONSTRAINT [PK_doc_password_history] PRIMARY KEY CLUSTERED ([change_pwd_id])
)


GO
