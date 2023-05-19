CREATE TABLE [dbo].[RxNT_Interface_Logs_Detail] (
   [log_details_id] [int] NOT NULL
      IDENTITY (1,1),
   [RecIDentifier] [nvarchar](max) NULL,
   [response] [nvarchar](max) NOT NULL,
   [status] [int] NULL,
   [CreatedDate] [datetime] NULL
)


GO
