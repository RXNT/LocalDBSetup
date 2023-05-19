CREATE TABLE [dbo].[patient_identifiers] (
   [pa_id] [bigint] NOT NULL,
   [pik_id] [bigint] NOT NULL,
   [value] [varchar](50) NULL

   ,CONSTRAINT [PK_patient_identifiers_1] PRIMARY KEY CLUSTERED ([pa_id], [pik_id])
)


GO
