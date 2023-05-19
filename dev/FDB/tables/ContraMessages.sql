CREATE TABLE [dbo].[ContraMessages] (
   [MsgNo] [smallint] NOT NULL,
   [Message] [varchar](80) NULL

   ,CONSTRAINT [PK_ContraMessages] PRIMARY KEY NONCLUSTERED ([MsgNo])
)

CREATE CLUSTERED INDEX [MAIN_INDX] ON [dbo].[ContraMessages] ([MsgNo])

GO
