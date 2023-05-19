CREATE TABLE [dbo].[patient_comm_pref] (
   [pa_id] [int] NOT NULL,
   [comm_pref] [int] NOT NULL,
   [cell_phone] [varchar](20) NULL,
   [email] [varchar](20) NULL

   ,CONSTRAINT [PK_patient_comm_pref] PRIMARY KEY CLUSTERED ([pa_id])
)


GO
