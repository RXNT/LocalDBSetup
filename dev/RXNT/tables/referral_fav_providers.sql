CREATE TABLE [dbo].[referral_fav_providers] (
   [prv_fav_id] [int] NOT NULL
      IDENTITY (1,1),
   [main_dr_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_referral_fav_providers] PRIMARY KEY CLUSTERED ([prv_fav_id])
)


GO
