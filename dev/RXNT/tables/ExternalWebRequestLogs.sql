CREATE TABLE [dbo].[ExternalWebRequestLogs] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [RequestUrl] [varchar](100) NOT NULL,
   [ReferralUrl] [varchar](100) NULL,
   [CreatedOn] [datetime] NOT NULL,
   [dc_id] [bigint] NOT NULL,
   [dr_id] [int] NULL

   ,CONSTRAINT [PK_ExternalWebRequestLogs] PRIMARY KEY CLUSTERED ([RequestId])
)


GO
