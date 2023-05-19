CREATE TABLE [dbo].[rxhub_eligibility_log] (
   [rel_id] [int] NOT NULL
      IDENTITY (1,1),
   [transaction_id] [varchar](50) NOT NULL,
   [request_date] [datetime] NOT NULL,
   [response_date] [datetime] NOT NULL,
   [request_trace_id] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_rxhub_eligibility_log] PRIMARY KEY CLUSTERED ([rel_id])
)


GO
