CREATE TABLE [dbo].[custom_drugs] (
   [CUST_ID] [int] NOT NULL
      IDENTITY (1,1),
   [DG_ID] [int] NOT NULL,
   [CUST_NAME] [varchar](80) NOT NULL,
   [CUST_OPT_XREF] [int] NOT NULL,
   [dc_id] [int] NOT NULL

   ,CONSTRAINT [IX_custom_drugs] UNIQUE CLUSTERED ([CUST_ID], [CUST_OPT_XREF], [DG_ID])
   ,CONSTRAINT [PK_custom_drugs] PRIMARY KEY NONCLUSTERED ([CUST_ID])
)

CREATE NONCLUSTERED INDEX [IX_ALT] ON [dbo].[custom_drugs] ([DG_ID], [dc_id])

GO
