CREATE TABLE [phr].[PatientTextLog] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [PhoneNumber] [varchar](11) NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [PatientId] [int] NULL,
   [Type] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [ApplicationId] [int] NOT NULL,
   [CreatedDateUtc] [datetime2] NOT NULL,
   [CreatedByDoctorId] [int] NULL,
   [CreatedByPatientId] [int] NULL,
   [InactivatedDateUtc] [datetime2] NULL,
   [InactivatedByDoctorId] [int] NULL

   ,CONSTRAINT [PK_PatientTextLog] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
