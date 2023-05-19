CREATE TABLE [dbo].[ContraIndications] (
   [TXR] [varchar](8) NULL,
   [ICD9] [varchar](6) NULL,
   [Message1] [smallint] NULL,
   [Message2] [smallint] NULL,
   [Message3] [smallint] NULL,
   [Message4] [smallint] NULL

)

CREATE NONCLUSTERED INDEX [IX_ContraIndications] ON [dbo].[ContraIndications] ([TXR], [ICD9])
CREATE NONCLUSTERED INDEX [IX_ContraIndications_1] ON [dbo].[ContraIndications] ([TXR], [Message1], [Message2], [Message3], [Message4])

GO
