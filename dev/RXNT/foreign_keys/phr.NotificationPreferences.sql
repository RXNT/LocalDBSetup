ALTER TABLE [phr].[NotificationPreferences] WITH CHECK ADD CONSTRAINT [FK__Notificat__Notif__2662B04F]
   FOREIGN KEY([NotificationId]) REFERENCES [phr].[Notifications] ([NotificationId])

GO
