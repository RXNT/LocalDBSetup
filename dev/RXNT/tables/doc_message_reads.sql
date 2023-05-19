CREATE TABLE [dbo].[doc_message_reads] (
   [ReadID] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [DrMsgID] [int] NULL,
   [ReadDate] [datetime] NULL

   ,CONSTRAINT [PK_doc_message_reads] PRIMARY KEY CLUSTERED ([ReadID])
)

CREATE NONCLUSTERED INDEX [IX_doc_message_reads-dr_id-DrMsgID] ON [dbo].[doc_message_reads] ([dr_id]) INCLUDE ([DrMsgID])

GO
