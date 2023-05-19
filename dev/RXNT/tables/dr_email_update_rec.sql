CREATE TABLE [dbo].[dr_email_update_rec] (
   [dr_id] [int] NOT NULL,
   [last_update_date] [datetime] NOT NULL,
   [last_refill_mail_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_dr_email_update_rec] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
