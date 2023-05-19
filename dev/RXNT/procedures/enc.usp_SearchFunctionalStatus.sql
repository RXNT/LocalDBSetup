SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To search the goals
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_SearchFunctionalStatus]
	@Name VARCHAR(50),
	@MaxRows INT = 50,
	@DoctorGroupId BIGINT
AS 
BEGIN
	SET NOCOUNT ON;
	 SELECT DISTINCT TOP (@MaxRows) snom_id, Name, SnomedCode, Category 
	 FROM [doc_groups_snomed] 
	 WHERE Category = 'FunctionalStatus' AND dg_id = @DoctorGroupId AND Name LIKE '%' + @Name + '%'
	 ORDER BY Name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
