CREATE TABLE [dbo].[rxhub_claims_log] (
   [rxclaim_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [ctrlref] [varchar](150) NOT NULL,
   [request] [text] NULL,
   [response] [text] NULL,
   [request_date] [datetime] NULL,
   [pa_id] [int] NOT NULL

   ,CONSTRAINT [PK_rxhub_claims_log] PRIMARY KEY CLUSTERED ([rxclaim_id])
)


GO
