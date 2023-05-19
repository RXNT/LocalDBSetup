CREATE TABLE [dbo].[ICWTransmitter_transactions] (
   [icwtransmit_id] [int] NOT NULL
      IDENTITY (1,1),
   [pt_id] [int] NULL,
   [request_date] [datetime] NOT NULL,
   [prescription_type] [tinyint] NOT NULL,
   [response_date] [datetime] NULL,
   [response_type] [smallint] NOT NULL,
   [icw_message_id] [varchar](128) NULL,
   [response_text] [varchar](255) NULL,
   [PD_ID] [int] NOT NULL,
   [pres_void_transmit] [bit] NOT NULL

   ,CONSTRAINT [PK_ICWTransmitter_transactions] PRIMARY KEY CLUSTERED ([icwtransmit_id])
)


GO
