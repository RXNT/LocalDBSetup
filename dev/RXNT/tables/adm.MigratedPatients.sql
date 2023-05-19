CREATE TABLE [adm].[MigratedPatients] (
   [migrated_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [ExternalPatientId] [bigint] NULL,
   [request_id] [bigint] NOT NULL,
   [status] [int] NOT NULL,
   [retry_count] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastEditedOn] [datetime] NULL

   ,CONSTRAINT [PK_MigratedPatients] PRIMARY KEY CLUSTERED ([migrated_id])
)


GO
