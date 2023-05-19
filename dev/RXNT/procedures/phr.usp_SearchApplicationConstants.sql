SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	15-OCT-2018
Description			:	This procedure is used to Search Application Constants
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_SearchApplicationConstants]	
	-- Add the parameters for the stored procedure here
	@Code			VARCHAR(5)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ATC.ApplicationTableConstantId, ATC.Code, ATC.Description
	FROM ehr.ApplicationTableConstants ATC WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON ATC.ApplicationTableId=AT.ApplicationTableId
	WHERE AT.Code=@Code
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
