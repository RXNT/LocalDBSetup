CREATE TABLE [dbo].[Patient_CCD_request_batch_filter] (
   [batchid] [bigint] NOT NULL,
   [enc_start_date] [datetime] NULL,
   [enc_end_date] [datetime] NULL,
   [enc_dr_id] [bigint] NULL,
   [pat_last_name] [varchar](50) NULL,
   [pat_first_name] [varchar](50) NULL,
   [pat_zip] [varchar](10) NULL,
   [pat_dob] [datetime] NULL,
   [reffered_to_dr_id] [bigint] NULL,
   [reffered_by_name] [varchar](50) NULL,
   [created_by] [bigint] NULL,
   [created_on] [datetime] NULL,
   [is_processed] [bit] NULL,
   [processed_on] [datetime] NULL

   ,CONSTRAINT [PK_Patient_CCD_request_batch_filter] PRIMARY KEY CLUSTERED ([batchid])
)


GO
