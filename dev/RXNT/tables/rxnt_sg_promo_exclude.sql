CREATE TABLE [dbo].[rxnt_sg_promo_exclude] (
   [ad_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [exclude_status] [bit] NOT NULL,
   [promo_exclude_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_rxnt_sg_promo_exclude] PRIMARY KEY CLUSTERED ([promo_exclude_id])
)

CREATE NONCLUSTERED INDEX [IX_rxnt_sg_promo_exclude] ON [dbo].[rxnt_sg_promo_exclude] ([dr_id], [ad_id])

GO
