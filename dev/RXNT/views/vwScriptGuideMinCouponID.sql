SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[vwScriptGuideMinCouponID] 
as 
select min(SGCouponID) AS SGCouponID, ForSGID 
from ScriptGuideCoupons 
group by ForSGID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
