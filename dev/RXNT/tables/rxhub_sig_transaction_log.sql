CREATE TABLE [dbo].[rxhub_sig_transaction_log] (
   [rstl_id] [int] NOT NULL
      IDENTITY (1,1),
   [transaction_id] [varchar](50) NOT NULL,
   [transaction_trace_reference] [varchar](50) NOT NULL,
   [request_trace_id] [varchar](50) NOT NULL,
   [transaction_type] [smallint] NOT NULL,
   [request_date] [datetime] NOT NULL,
   [request_data] [text] NULL,
   [response_data] [text] NULL

   ,CONSTRAINT [PK_rxhub_sig_transaction_log] PRIMARY KEY CLUSTERED ([rstl_id])
)


GO
