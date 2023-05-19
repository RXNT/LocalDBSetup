SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[vwScriptGuideMinCouponCode] 
as 
select C.ForSGID, C.SGCouponCode from ScriptGuideCoupons C 
inner join vwScriptGuideMinCouponID X ON C.SGCouponID = X.SGCouponID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
