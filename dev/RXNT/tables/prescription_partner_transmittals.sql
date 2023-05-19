CREATE TABLE [dbo].[prescription_partner_transmittals] (
   [pt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NULL,
   [pd_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [prescription_type] [tinyint] NOT NULL,
   [partner_id] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL

   ,CONSTRAINT [PK_prescription_partner_transmittals] PRIMARY KEY CLUSTERED ([pt_id])
)

CREATE NONCLUSTERED INDEX [ix_prescription_partner_transmittals_pd_id_includes] ON [dbo].[prescription_partner_transmittals] ([pd_id]) INCLUDE ([pres_id], [send_date])

GO
