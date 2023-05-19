CREATE TABLE [dbo].[referral_transmittals] (
   [referral_transmit_id] [int] NOT NULL
      IDENTITY (1,1),
   [referral_id] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](225) NULL,
   [delivery_method] [tinyint] NOT NULL,
   [queued_date] [datetime] NULL

   ,CONSTRAINT [PK_referral_transmittals] PRIMARY KEY CLUSTERED ([referral_transmit_id])
)

CREATE NONCLUSTERED INDEX [IX_referral_transmittals] ON [dbo].[referral_transmittals] ([referral_id], [delivery_method], [queued_date], [send_date])

GO
