CREATE TABLE [dbo].[aux_doc_messages] (
   [DrMsgId] [int] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NULL,
   [DrMsgDate] [datetime] NULL,
   [DrMsgBy] [varchar](100) NULL,
   [DrMessage] [text] NULL,
   [showMessage] [bit] NOT NULL

   ,CONSTRAINT [PK_aux_doc_messages] PRIMARY KEY CLUSTERED ([DrMsgId])
)


GO
