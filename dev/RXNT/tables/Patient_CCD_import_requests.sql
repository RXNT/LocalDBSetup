CREATE TABLE [dbo].[Patient_CCD_import_requests] (
   [request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [dr_id] [bigint] NOT NULL,
   [updated_on] [datetime] NOT NULL,
   [ccd_file_location] [varchar](max) NULL,
   [max_retry_count] [int] NOT NULL,
   [status] [int] NOT NULL,
   [requested_by] [bigint] NOT NULL,
   [requested_on] [datetime] NOT NULL,
   [comments] [varchar](max) NULL

   ,CONSTRAINT [PK_Patient_CCD_imoprt_requests] PRIMARY KEY CLUSTERED ([request_id])
)


GO
