CREATE TABLE [dbo].[coupon_redemptions] (
   [pa_id] [int] NOT NULL,
   [coupon_id] [int] NOT NULL,
   [medid] [int] NOT NULL,
   [coupon_code] [varchar](125) NOT NULL,
   [print_date] [smalldatetime] NOT NULL,
   [user_id] [int] NOT NULL,
   [coupon_redemption_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_coupon_redemptions] PRIMARY KEY CLUSTERED ([coupon_redemption_id])
)

CREATE NONCLUSTERED INDEX [IX_coupon_redemptions] ON [dbo].[coupon_redemptions] ([pa_id], [coupon_id], [medid])

GO
