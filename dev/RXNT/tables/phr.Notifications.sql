CREATE TABLE [phr].[Notifications] (
   [NotificationId] [int] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](10) NOT NULL,
   [Description] [varchar](max) NULL,
   [EnableSMS] [bit] NOT NULL,
   [EnableEmail] [bit] NOT NULL,
   [EnablePush] [bit] NOT NULL

   ,CONSTRAINT [PK__Notifica__20CF2E1281FC9A8C] PRIMARY KEY CLUSTERED ([NotificationId])
)


GO
