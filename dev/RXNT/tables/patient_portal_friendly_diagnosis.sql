CREATE TABLE [dbo].[patient_portal_friendly_diagnosis] (
   [friendly_diagnosis_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [friendly_diagnosis_text] [varchar](255) NOT NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_patient_portal_friendly_diagnosis] PRIMARY KEY CLUSTERED ([friendly_diagnosis_id])
)


GO
