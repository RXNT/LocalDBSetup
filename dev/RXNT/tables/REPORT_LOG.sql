CREATE TABLE [dbo].[REPORT_LOG] (
   [report_id] [int] NOT NULL
      IDENTITY (1,1),
   [VERSION] [varchar](2) NOT NULL,
   [FILE_NAME] [varchar](50) NOT NULL,
   [PARTNER_NAME] [varchar](20) NULL,
   [TRANSMIT_DATE] [smalldatetime] NULL,
   [TRANSACT_FILE_TYPE] [varchar](50) NULL,
   [EXTRACT_DATE] [smalldatetime] NULL,
   [FILE_TYPE] [varchar](1) NULL,
   [START_DATE] [smalldatetime] NULL,
   [END_DATE] [smalldatetime] NULL,
   [RESPONSE_TYPE] [bit] NULL,
   [RESPONSE_FILE_NAME] [varchar](200) NULL

   ,CONSTRAINT [PK_REPORT_LOG] PRIMARY KEY CLUSTERED ([report_id])
)


GO
