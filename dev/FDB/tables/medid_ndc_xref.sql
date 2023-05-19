CREATE TABLE [dbo].[medid_ndc_xref] (
   [medid] [numeric](8,0) NOT NULL,
   [ndc] [varchar](11) NULL

)

CREATE CLUSTERED INDEX [IX_MAIN] ON [dbo].[medid_ndc_xref] ([medid])

GO
