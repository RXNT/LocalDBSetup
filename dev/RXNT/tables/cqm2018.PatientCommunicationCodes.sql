CREATE TABLE [cqm2018].[PatientCommunicationCodes] (
   [CommunicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [CommunicationId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientCommunicationCodes] PRIMARY KEY CLUSTERED ([CommunicationCodeId])
)


GO
