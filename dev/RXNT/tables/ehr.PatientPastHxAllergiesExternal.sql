CREATE TABLE [ehr].[PatientPastHxAllergiesExternal] (
   [PatientPastHxAllergyExtId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [AllergyId] [bigint] NULL,
   [AllergyType] [bigint] NULL,
   [AllergyDescription] [varchar](500) NULL,
   [RecordSource] [varchar](500) NULL,
   [SourceType] [varchar](3) NULL,
   [Comments] [varchar](2000) NULL,
   [Reaction] [varchar](200) NULL,
   [CreatedOn] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [rxnorm_code] [varchar](15) NULL,
   [reaction_snomed] [varchar](15) NULL,
   [allergy_snomed] [varchar](15) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_PatientPastHxAllergiesExternal] PRIMARY KEY CLUSTERED ([PatientPastHxAllergyExtId])
)


GO
