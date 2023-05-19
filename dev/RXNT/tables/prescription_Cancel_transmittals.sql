CREATE TABLE [dbo].[prescription_Cancel_transmittals] (
   [pct_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [pres_id] [int] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](255) NULL,
   [queued_date] [smalldatetime] NOT NULL,
   [send_date] [smalldatetime] NULL,
   [response_date] [smalldatetime] NULL,
   [retry_count] [int] NULL,
   [next_retry_on] [datetime] NULL

   ,CONSTRAINT [PK_prescription_Cancel_transmittals] PRIMARY KEY CLUSTERED ([pct_id])
)


GO
