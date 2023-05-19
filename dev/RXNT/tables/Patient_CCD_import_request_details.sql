CREATE TABLE [dbo].[Patient_CCD_import_request_details] (
   [request_detail_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [ccd_file_name] [varchar](max) NULL,
   [pa_id] [int] NULL,
   [request_id] [bigint] NOT NULL,
   [status] [int] NOT NULL,
   [max_retry_count] [int] NOT NULL,
   [created_on] [datetime] NOT NULL,
   [updated_on] [datetime] NULL,
   [status_message] [varchar](max) NULL

   ,CONSTRAINT [PK_Patient_CCD_imoprt_request_details] PRIMARY KEY CLUSTERED ([request_detail_id])
)


GO
