CREATE TABLE [dbo].[Patient_merge_request_queue] (
   [pa_merge_reqid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_merge_batchid] [bigint] NOT NULL,
   [primary_pa_id] [int] NULL,
   [secondary_pa_id] [int] NULL,
   [comments] [varchar](500) NULL,
   [created_date] [datetime] NULL,
   [created_by] [int] NULL,
   [modified_by] [int] NULL,
   [modified_date] [datetime] NULL,
   [active] [bit] NOT NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_merge_request_queue] PRIMARY KEY CLUSTERED ([pa_merge_reqid])
)

CREATE NONCLUSTERED INDEX [ix_Patient_merge_request_queue_primary_pa_id_includes] ON [dbo].[Patient_merge_request_queue] ([primary_pa_id]) INCLUDE ([pa_merge_batchid])
CREATE NONCLUSTERED INDEX [ix_Patient_merge_request_queue_secondary_pa_id_status] ON [dbo].[Patient_merge_request_queue] ([secondary_pa_id], [status])

GO
