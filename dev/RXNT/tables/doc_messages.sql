CREATE TABLE [dbo].[doc_messages] (
   [DrMsgID] [int] NOT NULL
      IDENTITY (1,1),
   [DrMsgDate] [datetime] NULL,
   [DrMsgBy] [varchar](100) NULL,
   [DrMessage] [text] NULL,
   [DrIsComplete] [bit] NULL

   ,CONSTRAINT [PK_doc_messages] PRIMARY KEY CLUSTERED ([DrMsgID])
)


GO
