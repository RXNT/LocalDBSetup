CREATE TABLE [dbo].[rxntliberty_transmittals] (
   [rlt_id] [int] NOT NULL
      IDENTITY (1,1),
   [liberty_details_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [send_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [response_type] [smallint] NULL,
   [response_text] [varchar](500) NULL

   ,CONSTRAINT [PK_rxntliberty_transmittals] PRIMARY KEY CLUSTERED ([rlt_id])
)


GO
