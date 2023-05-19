CREATE TABLE [dbo].[patient_activemeds_deleted] (
   [pam_delete_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [delete_date] [smalldatetime] NOT NULL,
   [deleted_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_activemeds_deleted] PRIMARY KEY CLUSTERED ([pam_delete_id])
)


GO
