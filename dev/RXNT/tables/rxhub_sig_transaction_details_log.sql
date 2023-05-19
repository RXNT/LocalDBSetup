CREATE TABLE [dbo].[rxhub_sig_transaction_details_log] (
   [rstdl_id] [int] NOT NULL
      IDENTITY (1,1),
   [rstl_id] [int] NOT NULL,
   [transaction_id] [varchar](50) NOT NULL,
   [transaction_trace_reference] [varchar](50) NOT NULL,
   [response_date] [datetime] NOT NULL,
   [response_code] [varchar](15) NULL,
   [response_code_qualifier] [varchar](15) NULL,
   [response_message] [varchar](255) NULL,
   [comments] [varchar](255) NULL,
   [request_message] [text] NULL,
   [raw_response] [text] NULL

   ,CONSTRAINT [PK_rxhub_sig_transaction_details_log] PRIMARY KEY CLUSTERED ([rstdl_id])
)


GO
