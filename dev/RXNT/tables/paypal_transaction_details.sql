CREATE TABLE [dbo].[paypal_transaction_details] (
   [paypal_transaction_id] [int] NOT NULL
      IDENTITY (1,1),
   [paykey] [varchar](50) NOT NULL,
   [transaction_status] [varchar](50) NOT NULL,
   [correlation_id] [varchar](50) NOT NULL,
   [time_stamp] [datetime] NOT NULL,
   [rxnt_transaction_id] [varchar](50) NOT NULL,
   [rxnt_transaction_status] [varchar](50) NOT NULL,
   [rxnt_amount] [decimal](18,2) NOT NULL,
   [rxnt_account_id] [varchar](50) NOT NULL,
   [doctor_transaction_id] [varchar](50) NOT NULL,
   [doctor_transaction_status] [varchar](50) NOT NULL,
   [doctor_amount] [decimal](18,2) NOT NULL,
   [doctor_account_id] [varchar](50) NOT NULL,
   [dg_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NULL,
   [pa_last] [varchar](50) NOT NULL,
   [dg_name] [varchar](80) NOT NULL

   ,CONSTRAINT [PK_paypal_transaction_details] PRIMARY KEY CLUSTERED ([paypal_transaction_id])
)


GO
