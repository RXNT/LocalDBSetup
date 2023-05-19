CREATE TABLE [dbo].[RxNT_Interface_Logs] (
   [RxNT_Interface_Log_Id] [int] NOT NULL
      IDENTITY (1,1),
   [RecIDentifier] [varchar](50) NULL,
   [ReceivedDatetime] [datetime] NULL,
   [PartnerName] [varchar](50) NULL,
   [IncomingIPAddress] [varchar](50) NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [int] NULL,
   [msgText] [varchar](max) NULL

   ,CONSTRAINT [PK_RxNT_Interface_Logs_new] PRIMARY KEY CLUSTERED ([RxNT_Interface_Log_Id])
)


GO
