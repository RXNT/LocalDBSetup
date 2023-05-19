SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To search the procedure codes
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_SearchProcedureCodes]
	@Name VARCHAR(50),
	@MaxRows INT = 50,
	@IncludeCDT BIT = 0
AS

BEGIN
	SET NOCOUNT ON;
	SELECT TOP (@MaxRows) code, description from cpt_codes a WITH(NOLOCK)
	WHERE (code LIKE '%'+@Name+'%' OR description like '%'+ @Name+ '%') 
	AND (@IncludeCDT=1 OR A.ProcedureCodeTypeId IS NULL)
	ORDER BY code

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
