CREATE TABLE [dbo].[prescription_transmittals_archive] (
   [pt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NULL,
   [pd_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [transmission_flags] [int] NULL,
   [prescription_type] [tinyint] NOT NULL,
   [send_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL,
   [confirmation_id] [varchar](125) NULL,
   [transportmethod] [smallint] NULL,
   [dialingtime] [int] NULL,
   [connectiontime] [int] NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL

   ,CONSTRAINT [PK_prescription_transmittals_archive] PRIMARY KEY CLUSTERED ([pt_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[prescription_transmittals_archive] ([pres_id], [pd_id], [delivery_method], [queued_date], [send_date], [response_type])

GO
