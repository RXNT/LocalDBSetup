CREATE TABLE [dbo].[patient_consent] (
   [consent_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_consent] PRIMARY KEY CLUSTERED ([consent_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [PA_DR_INDX] ON [dbo].[patient_consent] ([pa_id], [dr_id])

GO
