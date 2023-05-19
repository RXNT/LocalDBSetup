CREATE TABLE [dbo].[patient_family_hx] (
   [fhxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pat_id] [bigint] NOT NULL,
   [member_relation_id] [int] NULL,
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
   [icd10] [varchar](max) NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL,
   [LivingStatus] [varchar](50) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_family_hx] PRIMARY KEY CLUSTERED ([fhxid])
)

CREATE NONCLUSTERED INDEX [ix_patient_family_hx_pat_id] ON [dbo].[patient_family_hx] ([pat_id])
CREATE NONCLUSTERED INDEX [ix_patient_family_hx_pat_id_enable] ON [dbo].[patient_family_hx] ([pat_id], [enable])
CREATE NONCLUSTERED INDEX [patient_family_hx_paid] ON [dbo].[patient_family_hx] ([fhxid], [pat_id])

GO
