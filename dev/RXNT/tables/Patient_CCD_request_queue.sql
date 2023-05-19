CREATE TABLE [dbo].[Patient_CCD_request_queue] (
   [reqid] [bigint] NOT NULL
      IDENTITY (1,1),
   [batchid] [bigint] NOT NULL,
   [pa_id] [bigint] NOT NULL,
   [created_date] [datetime] NULL,
   [created_by] [bigint] NULL,
   [modified_date] [datetime] NULL,
   [modified_by] [bigint] NULL,
   [active] [bit] NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_CCD_request_queue] PRIMARY KEY CLUSTERED ([reqid])
)


GO
