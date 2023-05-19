CREATE TABLE [dbo].[pending_transmittals] (
   [pres_id] [int] NULL,
   [refreq_id] [int] NOT NULL,
   [pending_ack] [bit] NOT NULL,
   [pres_delivery_method] [int] NOT NULL,
   [pres_send_date] [smalldatetime] NULL,
   [pres_read_date] [smalldatetime] NULL,
   [error_string] [varchar](255) NULL

   ,CONSTRAINT [PK_pending_transmittals] PRIMARY KEY CLUSTERED ([refreq_id])
)


GO
