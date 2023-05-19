CREATE TABLE [dbo].[pharm_messages] (
   [PharmMsgID] [int] NOT NULL
      IDENTITY (1,1),
   [PharmMsgDate] [datetime] NULL,
   [PharmMsgBy] [varchar](100) NULL,
   [PharmMessage] [text] NULL

   ,CONSTRAINT [PK_pharm_messages] PRIMARY KEY CLUSTERED ([PharmMsgID])
)


GO
