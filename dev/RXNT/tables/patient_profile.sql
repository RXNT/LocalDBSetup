CREATE TABLE [dbo].[patient_profile] (
   [profile_id] [int] NOT NULL
      IDENTITY (1,1),
   [patient_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [entry_date] [datetime] NOT NULL,
   [last_update_date] [datetime] NOT NULL,
   [last_update_dr_id] [int] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_profile] PRIMARY KEY CLUSTERED ([profile_id])
)

CREATE NONCLUSTERED INDEX [IDX_patient_profile_patient_id] ON [dbo].[patient_profile] ([patient_id])
CREATE NONCLUSTERED INDEX [IX_patient_profile] ON [dbo].[patient_profile] ([added_by_dr_id], [last_update_dr_id], [patient_id])

GO
