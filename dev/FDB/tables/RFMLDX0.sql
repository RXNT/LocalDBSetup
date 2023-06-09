CREATE TABLE [dbo].[RFMLDX0] (
   [DXID] [numeric](8,0) NOT NULL,
   [DXID_DESC56] [varchar](56) NULL,
   [DXID_DESC100] [varchar](100) NULL,
   [DXID_STATUS] [varchar](1) NOT NULL,
   [FDBDX] [varchar](9) NOT NULL,
   [DXID_DISEASE_DURATION_CD] [varchar](1) NOT NULL

   ,CONSTRAINT [RFMLDX0_PK] PRIMARY KEY CLUSTERED ([DXID])
)

CREATE NONCLUSTERED INDEX [_dta_index_RFMLDX0_12_1822629536__K1_3] ON [dbo].[RFMLDX0] ([DXID]) INCLUDE ([DXID_DESC100])
CREATE NONCLUSTERED INDEX [RFMLDX0_NX1] ON [dbo].[RFMLDX0] ([DXID_STATUS])
CREATE NONCLUSTERED INDEX [RFMLDX0_NX2] ON [dbo].[RFMLDX0] ([FDBDX])
CREATE NONCLUSTERED INDEX [RFMLDX0_NX3] ON [dbo].[RFMLDX0] ([DXID_DISEASE_DURATION_CD])

GO
