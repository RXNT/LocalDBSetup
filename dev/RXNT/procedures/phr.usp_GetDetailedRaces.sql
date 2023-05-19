SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author			:	Nambi
-- Created date		:	18-OCT-2018
-- Description		:	Get Detailed Races
-- =============================================
CREATE PROCEDURE  [phr].[usp_GetDetailedRaces]
 	
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ATC.[ApplicationTableConstantId],[ATC].[Description],PR.RACE_ID, SLC.ApplicationTableConstantCode As ParentCode
	FROM [ehr].[PatientRaceLookUpTable] PR WITH(NOLOCK)
	INNER JOIN [ehr].[SysLookupCodes] SLC WITH(NOLOCK) ON SLC.Code=PR.PARENT_RACE_ID
	INNER JOIN [ehr].[ApplicationTableConstants] ATC WITH(NOLOCK) ON PR.RACE_ID= ATC.Code
	INNER JOIN [ehr].[ApplicationTableConstants] ATCP WITH(NOLOCK) ON SLC.ApplicationTableConstantCode = ATCP.ApplicationTableConstantId
	INNER JOIN [ehr].[ApplicationTables] AT WITH(NOLOCK) ON  AT.ApplicationTableId = ATC.ApplicationTableId AND AT.Code = 'PARCE'
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
