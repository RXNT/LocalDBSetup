CREATE TABLE [dbo].[ScriptGuideCoupons] (
   [SGCouponID] [int] NOT NULL
      IDENTITY (1,1),
   [ForSGID] [int] NOT NULL,
   [SGCouponCode] [varchar](50) NOT NULL,
   [used] [bit] NOT NULL

   ,CONSTRAINT [PK_ScriptGuideCoupons] PRIMARY KEY CLUSTERED ([SGCouponID])
)


GO
