CREATE TABLE [dbo].[rxntlibertydetails] (
   [liberty_do_id] [bigint] NOT NULL,
   [line_item_id] [int] NOT NULL,
   [msg_ref_id] [varchar](50) NOT NULL,
   [receive_date] [datetime] NOT NULL,
   [message] [xml] NOT NULL,
   [response_type] [int] NULL,
   [response_date] [datetime] NULL,
   [response_status] [smallint] NULL,
   [response_text] [varchar](500) NULL,
   [liberty_details_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__rxntlibertydetai__318EDC78] PRIMARY KEY CLUSTERED ([liberty_details_id])
)

CREATE NONCLUSTERED INDEX [IX_rxntlibertydetails-liberty_do_id-incld] ON [dbo].[rxntlibertydetails] ([liberty_do_id]) INCLUDE ([msg_ref_id], [response_type], [response_date], [response_text], [liberty_details_id])

GO
