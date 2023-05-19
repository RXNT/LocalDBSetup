CREATE TABLE [dbo].[drug_map] (
   [medid] [numeric](8,0) NOT NULL,
   [NDC] [varchar](11) NULL,
   [MED_ROUTE_DESC] [varchar](30) NULL,
   [MED_STRENGTH] [varchar](15) NULL,
   [MED_STRENGTH_UOM] [varchar](15) NULL

   ,CONSTRAINT [PK_drug_map] PRIMARY KEY CLUSTERED ([medid])
)

CREATE NONCLUSTERED INDEX [ix_main] ON [dbo].[drug_map] ([medid])

GO
