CREATE TABLE [dbo].[referral_fav_providers_old] (
   [prv_fav_id] [int] NOT NULL,
   [main_dr_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_referral_fav_providers_old] PRIMARY KEY CLUSTERED ([prv_fav_id])
)


GO
