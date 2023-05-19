CREATE TABLE [dbo].[ErrorNotificationConfig] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [Severity] [varchar](100) NOT NULL,
   [EnableEmailLog] [varchar](1) NOT NULL
)


GO
