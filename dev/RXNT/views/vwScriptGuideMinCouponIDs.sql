SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[vwScriptGuideMinCouponIDs] 
as 
select min(SGCouponID) AS MinSGCouponID, ForSGID 
from ScriptGuideCoupons 
group by ForSGID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
