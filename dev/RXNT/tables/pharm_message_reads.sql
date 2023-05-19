CREATE TABLE [dbo].[pharm_message_reads] (
   [ReadID] [int] NOT NULL
      IDENTITY (1,1),
   [pharm_user_id] [int] NULL,
   [PharmMsgID] [int] NULL,
   [ReadDate] [datetime] NULL

   ,CONSTRAINT [PK_pharm_message_reads] PRIMARY KEY CLUSTERED ([ReadID])
)


GO
