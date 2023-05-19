CREATE TABLE [dbo].[prescription_void_transmittals] (
   [pvt_id] [int] NOT NULL
      IDENTITY (1,1),
   [refreq_id] [int] NOT NULL,
   [pres_id] [int] NULL,
   [pd_id] [int] NULL,
   [queued_date] [datetime] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [confirmation_id] [varchar](255) NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL

   ,CONSTRAINT [PK_prescription_void_transmittals] PRIMARY KEY NONCLUSTERED ([pvt_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_presid_pvt] ON [dbo].[prescription_void_transmittals] ([pres_id])
CREATE NONCLUSTERED INDEX [IX_prescription_void_transmittals-send_date-response_date] ON [dbo].[prescription_void_transmittals] ([send_date], [response_date])
CREATE UNIQUE CLUSTERED INDEX [Pk_Pvt] ON [dbo].[prescription_void_transmittals] ([pvt_id])

GO
