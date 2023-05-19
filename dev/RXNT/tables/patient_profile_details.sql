CREATE TABLE [dbo].[patient_profile_details] (
   [profile_id] [int] NOT NULL,
   [item_id] [int] NOT NULL,
   [item_text] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_patient_profile_details] PRIMARY KEY CLUSTERED ([profile_id], [item_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_profile_details] ON [dbo].[patient_profile_details] ([profile_id], [item_id])

GO
