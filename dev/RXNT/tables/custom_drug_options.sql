CREATE TABLE [dbo].[custom_drug_options] (
   [cust_drug_option_id] [int] NOT NULL
      IDENTITY (1,1),
   [CUST_OPTION_ID] [int] NOT NULL,
   [MEDID] [int] NOT NULL,
   [add_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_custom_drug_options] PRIMARY KEY CLUSTERED ([cust_drug_option_id])
)

CREATE NONCLUSTERED INDEX [IX_custom_drug_options_1] ON [dbo].[custom_drug_options] ([CUST_OPTION_ID], [MEDID])

GO
