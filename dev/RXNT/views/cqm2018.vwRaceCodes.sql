SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [cqm2018].[vwRaceCodes]
AS
SELECT 2 RaceId,'1002-5' AS RaceCode,'American Indian or Alaska Native' Description
UNION
SELECT 4 RaceId,'2028-9' AS RaceCode, 'Asian' Description
UNION
SELECT 8 RaceId, '2054-5' AS RaceCode, 'Black or African American' Description
UNION 
SELECT 16 RaceId, '2076-8' AS RaceCode, 'Native Hawaiian or Other Pacific Islander' Description
UNION 
SELECT 32 RaceId, '2106-3' AS RaceCode, 'White' Description
UNION 
SELECT 128 RaceId, '2131-1' AS RaceCode, 'Other Race' Description
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
