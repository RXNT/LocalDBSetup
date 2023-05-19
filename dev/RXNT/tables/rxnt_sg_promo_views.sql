CREATE TABLE [dbo].[rxnt_sg_promo_views] (
   [ad_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [ad_date] [smalldatetime] NOT NULL,
   [promo_views_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_rxnt_sg_promo_views] PRIMARY KEY CLUSTERED ([promo_views_id])
)


GO
