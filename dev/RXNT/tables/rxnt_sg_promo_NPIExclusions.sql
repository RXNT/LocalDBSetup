CREATE TABLE [dbo].[rxnt_sg_promo_NPIExclusions] (
   [SGPromoNPIExclusionID] [int] NOT NULL
      IDENTITY (1,1),
   [ForADID] [int] NOT NULL,
   [NPI] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_SGPromoNPIExclusions] PRIMARY KEY CLUSTERED ([SGPromoNPIExclusionID])
)


GO
