CREATE TABLE [dbo].[palm_drugs] (
   [MEDID] [numeric](8,0) NOT NULL,
   [MED_MEDID_DESC] [varchar](70) NOT NULL,
   [GCN_SEQNO] [numeric](6,0) NULL,
   [OBSDTEC] [datetime] NULL

)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[palm_drugs] ([MEDID], [OBSDTEC])

GO
