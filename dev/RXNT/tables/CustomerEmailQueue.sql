CREATE TABLE [dbo].[CustomerEmailQueue] (
   [CEMID] [int] NOT NULL
      IDENTITY (1,1),
   [CustID] [int] NOT NULL,
   [EmpID] [int] NOT NULL,
   [OrderID] [int] NOT NULL,
   [CEMMTYPEID] [int] NOT NULL,
   [dtQueueDate] [datetime] NOT NULL,
   [dtSendDate] [datetime] NULL,
   [bSendAttempted] [bit] NOT NULL,
   [bSMTPSVGFailed] [bit] NOT NULL,
   [strSMTPSVGErrorMsg] [varchar](1000) NOT NULL,
   [strMDFailedAddress] [varchar](255) NOT NULL,
   [strSubject] [varchar](400) NOT NULL,
   [strMDSessionTranscript] [text] NOT NULL,
   [strBody] [text] NOT NULL,
   [lngMasterOrderID] [int] NOT NULL

   ,CONSTRAINT [PK_CustomerEmailQueue] PRIMARY KEY CLUSTERED ([CEMID])
)


GO
