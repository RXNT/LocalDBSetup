CREATE TABLE [support].[Patients_Copy_Ref_Extended] (
   [CopyRef_Id] [bigint] NOT NULL,
   [PatientExtendedDetailsCopied] [bit] NULL,
   [PatientActiveMedsCopied] [bit] NULL,
   [PatientActiveDiagnosisCopied] [bit] NULL,
   [PatientAllergiesCopied] [bit] NULL,
   [PatientHistoryCopied] [bit] NULL,
   [PatientImmunizationsCopied] [bit] NULL,
   [PatientProceduresCopied] [bit] NULL,
   [PatientReferralsCopied] [bit] NULL,
   [PatientVitalsCopied] [bit] NULL,
   [PatientDocumentsCopied] [bit] NULL,
   [PatientEncounterCopied] [bit] NULL,
   [PatientLabOrdersCopied] [bit] NULL,
   [PatientLabResultsCopied] [bit] NULL,
   [CreatedOn] [datetime] NULL,
   [LastUpdatedOn] [datetime] NULL,
   [PatientFavouritePharmaciesCopied] [bit] NULL,
   [PatientNotesCopied] [bit] NULL,
   [PatientPrescriptionsCopied] [bit] NULL,
   [PatientPrescriptionsArchiveCopied] [int] NULL,
   [PatientMedHxCopied] [bit] NULL,
   [PatientFormularyCopied] [bit] NULL,
   [PatientExternalFormularyCopied] [bit] NULL

   ,CONSTRAINT [PK_Patients_Copy_Ref_Extended] PRIMARY KEY CLUSTERED ([CopyRef_Id])
)


GO
