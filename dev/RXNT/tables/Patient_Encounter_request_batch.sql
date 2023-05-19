CREATE TABLE [dbo].[Patient_Encounter_request_batch] (
   [batchid] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [modified_by] [int] NULL,
   [modified_date] [datetime] NULL,
   [active] [bit] NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_Encounter_request_batch] PRIMARY KEY CLUSTERED ([batchid])
)


GO
