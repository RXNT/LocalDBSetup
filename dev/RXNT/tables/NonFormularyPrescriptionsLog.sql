CREATE TABLE [dbo].[NonFormularyPrescriptionsLog] (
   [PresLogId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorGroupId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [DoctorLastName] [varchar](50) NULL,
   [DoctorFirstName] [varchar](50) NULL,
   [PrimDoctorId] [bigint] NULL,
   [MainDoctorId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [PatientLastName] [varchar](50) NULL,
   [PatientFirstName] [varchar](50) NULL,
   [MedId] [bigint] NULL,
   [DrugName] [varchar](500) NULL,
   [PatientExtCoverageId] [bigint] NULL,
   [FormularyId] [varchar](100) NULL,
   [NDC] [varchar](50) NULL,
   [EntryDate] [datetime] NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [bigint] NULL

   ,CONSTRAINT [PK_NonFormularyPrescriptionsLog] PRIMARY KEY CLUSTERED ([PresLogId])
)


GO
