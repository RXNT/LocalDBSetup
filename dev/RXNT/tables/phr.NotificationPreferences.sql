CREATE TABLE [phr].[NotificationPreferences] (
   [NotificationPreferenceId] [int] NOT NULL
      IDENTITY (1,1),
   [NotificationId] [int] NOT NULL,
   [PatientId] [bigint] NULL,
   [RepresentativeId] [bigint] NULL,
   [EnableSMS] [bit] NULL,
   [EnableEmail] [bit] NULL,
   [EnablePush] [bit] NULL

   ,CONSTRAINT [PK__Notifica__1B80A6620ECD9609] PRIMARY KEY CLUSTERED ([NotificationPreferenceId])
)

CREATE NONCLUSTERED INDEX [idx_PatientId] ON [phr].[NotificationPreferences] ([PatientId])
CREATE NONCLUSTERED INDEX [idx_RepresentativeId] ON [phr].[NotificationPreferences] ([RepresentativeId])

GO
