CREATE TABLE [dbo].[RFMLINM0] (
   [ICD9CM] [varchar](20) NOT NULL,
   [ICD9CM_HCFADESC] [varchar](50) NULL,
   [ICD9CM_DESC100] [varchar](255) NULL,
   [ICD9CM_TYPE_CODE] [varchar](2) NOT NULL,
   [ICD9CM_SOURCE_CODE] [varchar](2) NOT NULL

   ,CONSTRAINT [RFMLINM0_PK] PRIMARY KEY CLUSTERED ([ICD9CM])
)

CREATE NONCLUSTERED INDEX [RFMLINM0_NX1] ON [dbo].[RFMLINM0] ([ICD9CM_SOURCE_CODE])
CREATE NONCLUSTERED INDEX [RFMLINM0_NX2] ON [dbo].[RFMLINM0] ([ICD9CM_TYPE_CODE])

GO
