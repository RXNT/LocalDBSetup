CREATE TABLE [dbo].[demo_customers] (
   [cst_id] [int] NOT NULL
      IDENTITY (1,1),
   [first_name] [varchar](50) NOT NULL,
   [last_name] [varchar](50) NOT NULL,
   [phone] [varchar](30) NOT NULL,
   [email] [varchar](100) NOT NULL,
   [sales_rep_id] [int] NOT NULL,
   [date_signed] [smalldatetime] NULL,
   [ip_addr] [varchar](50) NULL

   ,CONSTRAINT [PK_demo_customers] PRIMARY KEY CLUSTERED ([cst_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[demo_customers] ([cst_id], [email], [ip_addr])

GO
