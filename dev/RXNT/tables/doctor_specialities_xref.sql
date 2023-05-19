CREATE TABLE [dbo].[doctor_specialities_xref] (
   [dr_sp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [speciality_id] [int] NOT NULL

   ,CONSTRAINT [PK_doctor_specialities_xref] PRIMARY KEY CLUSTERED ([dr_sp_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_doctor_specialities_xref] ON [dbo].[doctor_specialities_xref] ([dr_id], [speciality_id])

GO
