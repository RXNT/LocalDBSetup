CREATE TABLE [dbo].[patient_identifier_keys] (
   [pik_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [keyname] [varchar](50) NULL

   ,CONSTRAINT [PK_patient_identifier_keys] PRIMARY KEY CLUSTERED ([pik_id])
)


GO
