SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	16-Jan-2017
Description			:	This procedure is used to Search lab test
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [enc].[usp_SearchLabTests]
	@SearchText			VARCHAR(MAX)
AS
BEGIN
	DECLARE @MaxRows INT = 100;
	SELECT TOP(@MaxRows) lab_test_id,lab_test_name,active,test_type 
	FROM lab_test_lists WITH(NOLOCK)
	WHERE active = 1 and lab_test_name like '%'+@SearchText+'%' AND test_type IN (0,1)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
