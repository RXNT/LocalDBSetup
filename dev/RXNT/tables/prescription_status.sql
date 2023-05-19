CREATE TABLE [dbo].[prescription_status] (
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

   ,CONSTRAINT [PK_prescription_status] PRIMARY KEY NONCLUSTERED ([ps_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_prescription_status_7_206011865__K2_K4_K3_K8_5_6_7] ON [dbo].[prescription_status] ([pd_id], [response_type], [delivery_method], [queued_date]) INCLUDE ([response_text], [response_date], [confirmation_id])
CREATE UNIQUE NONCLUSTERED INDEX [prescription_status_1] ON [dbo].[prescription_status] ([pd_id], [delivery_method])
CREATE CLUSTERED INDEX [prescription_status_2] ON [dbo].[prescription_status] ([pd_id])
CREATE NONCLUSTERED INDEX [prescription_status_3] ON [dbo].[prescription_status] ([pd_id], [delivery_method], [response_type], [response_date])

GO
