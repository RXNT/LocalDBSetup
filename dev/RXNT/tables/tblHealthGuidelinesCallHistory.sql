CREATE TABLE [dbo].[tblHealthGuidelinesCallHistory] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dgid] [bigint] NOT NULL,
   [patientid] [bigint] NOT NULL,
   [ruleid] [bigint] NOT NULL,
   [AccountSid] [varchar](50) NULL,
   [CallDuration] [float] NULL,
   [CallerName] [varchar](50) NULL,
   [CallSid] [varchar](50) NULL,
   [CallStatus] [varchar](30) NULL,
   [DialCallDuration] [varchar](10) NULL,
   [DialCallSid] [varchar](50) NULL,
   [DialCallStatus] [varchar](30) NULL,
   [Direction] [varchar](30) NULL,
   [From] [varchar](50) NULL,
   [To] [varchar](50) NULL,
   [CraetedOn] [datetime] NULL

   ,CONSTRAINT [PK__tblHealt__3214EC072F91856D] PRIMARY KEY CLUSTERED ([Id])
)


GO
