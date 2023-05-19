CREATE TABLE [cqm2019].[PatientCommunicationCodes] (
   [CommunicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [CommunicationId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientCommunicationCodes] PRIMARY KEY CLUSTERED ([CommunicationCodeId])
)


GO
