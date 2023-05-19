CREATE TABLE [dbo].[referral_status] (
   [rs_id] [int] NOT NULL
      IDENTITY (1,1),
   [referral_id] [int] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL,
   [confirmation_id] [varchar](125) NULL,
   [queued_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_referral_status] PRIMARY KEY CLUSTERED ([rs_id])
)

CREATE NONCLUSTERED INDEX [IX_referral_status] ON [dbo].[referral_status] ([delivery_method], [referral_id])
CREATE NONCLUSTERED INDEX [IX_referral_status-referral_id-incld] ON [dbo].[referral_status] ([referral_id]) INCLUDE ([delivery_method], [response_type], [response_text], [response_date])

GO
