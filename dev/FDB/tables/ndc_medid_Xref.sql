CREATE TABLE [dbo].[ndc_medid_Xref] (
   [medid] [numeric](8,0) NOT NULL,
   [ndc] [varchar](11) NULL

)

CREATE CLUSTERED INDEX [IX_MAIN] ON [dbo].[ndc_medid_Xref] ([medid])

GO
