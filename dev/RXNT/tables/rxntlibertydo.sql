CREATE TABLE [dbo].[rxntlibertydo] (
   [liberty_do_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [msg_ref_id] [varchar](50) NOT NULL,
   [type] [int] NOT NULL,
   [total_items] [int] NOT NULL,
   [received_items] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [start_date] [datetime] NOT NULL,
   [formMessage] [xml] NULL,
   [approved_date] [datetime] NULL,
   [void] [bit] NOT NULL,
   [form_type] [varchar](255) NOT NULL,
   [sent_item] [int] NOT NULL,
   [void_code] [smallint] NULL,
   [void_comments] [varchar](255) NULL

   ,CONSTRAINT [PK_rxntlibertydo] PRIMARY KEY CLUSTERED ([liberty_do_id])
)

CREATE NONCLUSTERED INDEX [IX_rxntlibertydo-approved_date] ON [dbo].[rxntlibertydo] ([approved_date])

GO
