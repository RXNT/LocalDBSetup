CREATE TABLE [dbo].[NDC_TXR] (
   [NDC] [varchar](11) NULL,
   [TXR] [varchar](8) NULL,
   [Description] [varchar](40) NULL,
   [TXR_EXT] [varchar](14) NULL

)

CREATE CLUSTERED INDEX [MAIN_INDX] ON [dbo].[NDC_TXR] ([NDC], [TXR])

GO
