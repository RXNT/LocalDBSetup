CREATE TABLE [erx].[RxChangeVoidTransmittals] (
   [ChgVoidId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ChgReqId] [int] NOT NULL,
   [Type] [tinyint] NULL,
   [PresId] [bigint] NULL,
   [PdId] [bigint] NULL,
   [DeliveryMethod] [bigint] NULL,
   [SendDate] [datetime] NULL,
   [QueuedDate] [datetime] NULL,
   [ResponseDate] [datetime] NULL,
   [ResponseType] [tinyint] NULL,
   [ResponseText] [varchar](250) NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL

   ,CONSTRAINT [PK_RxChangeVoidTransmittals] PRIMARY KEY CLUSTERED ([ChgVoidId])
)


GO
