SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:   JahabarYusuff M
Create date			:	13-Dec-2019
Description			:	This procedure is used to fetch application configuration
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE ehr.[usp_SelectApplicationConfiguration]
(
	@ApplicationTableCode varchar(5)
)
AS
BEGIN
	SELECT	ATP.ApplicationTableConstantId, 
			ATP.Code, 
			ATP.[Description], 
			ATP.SortOrder
	FROM	ehr.[ApplicationTableConstants]		ATP		WITH (NOLOCK)
			INNER JOIN ehr.[ApplicationTables]	AT		WITH (NOLOCK) ON AT.ApplicationTableId = ATP.ApplicationTableId
	WHERE	AT.Code LIKE N'' + @ApplicationTableCode AND
			ATP.Active = 1
	ORDER BY ATP.SortOrder ASC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
