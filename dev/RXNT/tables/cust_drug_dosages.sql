CREATE TABLE [dbo].[cust_drug_dosages] (
   [cust_drug_sig_id] [int] NOT NULL
      IDENTITY (1,1),
   [cust_id] [int] NOT NULL,
   [drugid] [int] NOT NULL,
   [dosage] [varchar](255) NOT NULL,
   [duration_unit] [varchar](80) NOT NULL,
   [duration_amount] [varchar](50) NOT NULL,
   [start_date] [datetime] NULL,
   [end_date] [datetime] NULL,
   [pharmacist_notes] [varchar](140) NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL

   ,CONSTRAINT [PK_cust_drug_dosages] PRIMARY KEY CLUSTERED ([cust_drug_sig_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[cust_drug_dosages] ([cust_id], [drugid])

GO
