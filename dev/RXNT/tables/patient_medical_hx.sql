CREATE TABLE [dbo].[patient_medical_hx] (
   [medhxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pat_id] [bigint] NOT NULL,
   [problem] [varchar](max) NULL,
   [icd9] [varchar](50) NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bit] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL,
   [source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_medical_hx] PRIMARY KEY CLUSTERED ([medhxid])
)

CREATE NONCLUSTERED INDEX [patient_medical_hx_paid] ON [dbo].[patient_medical_hx] ([medhxid], [pat_id])

GO
