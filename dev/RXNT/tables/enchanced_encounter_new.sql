CREATE TABLE [dbo].[enchanced_encounter_new] (
   [enc_id] [int] NOT NULL
      IDENTITY (1,1),
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [enc_text] [xml] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_enchanced_encounter1] PRIMARY KEY CLUSTERED ([enc_id])
)

CREATE NONCLUSTERED INDEX [IX_enchanced_encounter] ON [dbo].[enchanced_encounter_new] ([dr_id], [enc_date] DESC, [patient_id], [added_by_dr_id])
CREATE NONCLUSTERED INDEX [IX_enchanced_encounter-patient_id] ON [dbo].[enchanced_encounter_new] ([patient_id])

GO
