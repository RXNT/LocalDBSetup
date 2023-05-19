CREATE TABLE [dbo].[patient_registration_details] (
   [pa_reg_det_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_reg_id] [int] NOT NULL,
   [reg_name] [varchar](50) NOT NULL,
   [rep_name] [varchar](50) NOT NULL,
   [rep_rel] [varchar](25) NOT NULL,
   [comments] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_patient_registration_details] PRIMARY KEY CLUSTERED ([pa_reg_det_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_registration_details] ON [dbo].[patient_registration_details] ([pa_reg_id])

GO
