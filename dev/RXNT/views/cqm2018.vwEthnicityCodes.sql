SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [cqm2018].[vwEthnicityCodes]
AS
SELECT 1 EthnicityId,'2135-2' AS EthnicityCode,'Hispanic or Latino' Description
UNION
SELECT 2 EthnicityId,'2186-5' AS EthnicityCode, 'Not Hispanic or Latino' Description
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
