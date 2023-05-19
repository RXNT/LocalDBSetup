CREATE TABLE [dbo].[incoming_rx_messages] (
   [incoming_rx_messages_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [refreq_id] [bigint] NULL,
   [dr_id] [bigint] NULL,
   [message] [varchar](max) NOT NULL,
   [delivery_method] [int] NULL,
   [type] [varchar](50) NULL,
   [is_success] [bit] NULL,
   [exception] [varchar](500) NULL,
   [created_date] [datetime] NULL

   ,CONSTRAINT [PK_incoming_rx_messages] PRIMARY KEY CLUSTERED ([incoming_rx_messages_id])
)


GO
