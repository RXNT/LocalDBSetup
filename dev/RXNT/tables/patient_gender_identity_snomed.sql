CREATE TABLE [dbo].[patient_gender_identity_snomed] (
   [gender_identity_snomed_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_gender_identity_id] [int] NOT NULL,
   [pa_gender_identity] [varchar](75) NULL,
   [snomed_code] [varchar](25) NULL,
   [is_null_flavour] [bit] NULL

   ,CONSTRAINT [PK_patient_gender_identity_snomed] PRIMARY KEY CLUSTERED ([gender_identity_snomed_id])
)


GO
