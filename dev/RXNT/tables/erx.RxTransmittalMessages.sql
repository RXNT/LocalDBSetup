CREATE TABLE [erx].[RxTransmittalMessages] (
   [RtmId] [bigint] NOT NULL
      IDENTITY (1,1),
   [RxType] [int] NULL,
   [DoctorId] [bigint] NULL,
   [PatientId] [bigint] NULL,
   [RequestId] [varchar](50) NULL,
   [ResponseId] [varchar](50) NULL,
   [StartDate] [date] NULL,
   [EndDate] [date] NULL,
   [RequestMessage] [xml] NULL,
   [ResponseMessage] [xml] NULL,
   [CreatedDate] [date] NOT NULL,
   [DeliveryMethod] [bigint] NULL

   ,CONSTRAINT [PK_RxTransmittalMessages] PRIMARY KEY CLUSTERED ([RtmId])
)


GO
