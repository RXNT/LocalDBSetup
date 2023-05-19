CREATE TABLE [dbo].[dr_email_alert_rec] (
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NULL,
   [dr_email] [varchar](50) NULL,
   [active] [smallint] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [frequency] [int] NOT NULL,
   [last_process_date] [datetime] NULL

   ,CONSTRAINT [PK_dr_email_alert_rec] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
