CREATE TABLE [dbo].[doc_admin] (
   [dr_admin_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dr_partner_participant] [int] NOT NULL,
   [dr_service_level] [smallint] NOT NULL,
   [dr_partner_enabled] [bit] NOT NULL,
   [report_date] [smalldatetime] NOT NULL,
   [update_date] [smalldatetime] NOT NULL,
   [fail_lock] [bit] NULL,
   [version] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_doc_admin] PRIMARY KEY CLUSTERED ([dr_admin_id], [dr_id], [dr_partner_participant])
)

CREATE NONCLUSTERED INDEX [ix_doc_admin_dr_id_dr_partner_participant_version] ON [dbo].[doc_admin] ([dr_id], [dr_partner_participant], [version])

GO
