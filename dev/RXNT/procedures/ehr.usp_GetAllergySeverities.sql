SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	AFSAL Y
Create date			:	27-OCT-2017
Description			:	This procedure is used to get All Allergy Severities
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
 CREATE   PROCEDURE [ehr].[usp_GetAllergySeverities]	
AS
BEGIN
	SELECT [ATC].[ApplicationTableConstantId], 
	       [ATC].[Code], 
		   [ATC].[Description] 
	FROM [ehr].[ApplicationTableConstants] ATC WITH(NOLOCK)
	INNER JOIN [ehr].[ApplicationTables] AT WITH(NOLOCK) ON AT.ApplicationTableId = ATC.ApplicationTableId AND AT.Code = 'ALSVT'
	ORDER BY [ATC].[SortOrder]
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
