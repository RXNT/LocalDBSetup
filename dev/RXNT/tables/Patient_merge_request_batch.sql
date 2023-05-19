CREATE TABLE [dbo].[Patient_merge_request_batch] (
   [pa_merge_batchid] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NOT NULL,
   [modified_by] [int] NULL,
   [modified_date] [datetime] NULL,
   [active] [bit] NOT NULL,
   [batch_name] [varchar](100) NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_merge_request_batch] PRIMARY KEY CLUSTERED ([pa_merge_batchid])
)


GO
