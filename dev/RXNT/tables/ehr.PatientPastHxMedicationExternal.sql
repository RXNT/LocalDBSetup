CREATE TABLE [ehr].[PatientPastHxMedicationExternal] (
   [PatientPastHxMedicationExtId] [int] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [DrugId] [bigint] NOT NULL,
   [Comments] [varchar](255) NULL,
   [Reason] [varchar](150) NULL,
   [DrugName] [varchar](200) NULL,
   [Dosage] [varchar](255) NULL,
   [DurationAmount] [varchar](15) NULL,
   [DurationUnit] [varchar](80) NULL,
   [DrugComments] [varchar](255) NULL,
   [UseGeneric] [int] NULL,
   [DaysSupply] [smallint] NULL,
   [PrescriptionDetailId] [bigint] NULL,
   [Prn] [bit] NULL,
   [PrnDescription] [varchar](50) NULL,
   [DateStart] [datetime] NULL,
   [DateEnd] [datetime] NULL,
   [SourceType] [varchar](3) NULL,
   [RecordSource] [varchar](500) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [numb_refills] [int] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_active_meds_external] PRIMARY KEY CLUSTERED ([PatientPastHxMedicationExtId])
)


GO
