CREATE TABLE [dbo].[patient_hospitalization_hx] (
   [hosphxid] [bigint] NOT NULL
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
   [icd9_description] [varchar](max) NULL,
   [icd10] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL,
   [source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_hosp_hx] PRIMARY KEY CLUSTERED ([hosphxid])
)


GO
