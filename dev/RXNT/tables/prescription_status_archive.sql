CREATE TABLE [dbo].[prescription_status_archive] (
   [ps_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL,
   [confirmation_id] [varchar](125) NULL,
   [queued_date] [datetime] NOT NULL,
   [cancel_req_response_date] [smalldatetime] NULL,
   [cancel_req_response_type] [bit] NULL,
   [cancel_req_response_text] [varchar](255) NULL

   ,CONSTRAINT [PK_prescription_status_archive] PRIMARY KEY CLUSTERED ([ps_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_prescription_status_archive_9_2075258548__K2_K4_K5_K6_K3_K9_K10_K11] ON [dbo].[prescription_status_archive] ([pd_id], [response_type], [response_text], [response_date], [delivery_method], [cancel_req_response_date], [cancel_req_response_type], [cancel_req_response_text])

GO
