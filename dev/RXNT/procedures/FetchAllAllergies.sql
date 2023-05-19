SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FetchAllAllergies] 
	-- Add the parameters for the stored procedure here
	@PageIndex BIGINT = NULL, 
	@PageSize int = 1000
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	With ranked AS   --- Or you can make it a view
	(
		SELECT ROW_NUMBER() OVER(ORDER BY DAM_CONCEPT_ID ASC) AS RowNum,
		DAM_CONCEPT_ID AS [ALLERGYID(UniqueID)],DAM_CONCEPT_ID_DESC DESCRIPTION	,DAM_CONCEPT_ID_TYP [TYPEID(1-Allergen Group, 2-Drug Name, 6-Ingredient Name)]
		FROM RDAMAPM0 WITH(NOLOCK)
		LEFT OUTER JOIN patient_allergy_type at  WITH(NOLOCK) ON DAM_CONCEPT_ID_TYP=at.allergy_type
	)
	SELECT [ALLERGYID(UniqueID)],DESCRIPTION, [TYPEID(1-Allergen Group, 2-Drug Name, 6-Ingredient Name)]
	FROM Ranked
	WHERE RowNum BETWEEN ((@PageIndex - 1) * @PageSize + 1) AND (@PageIndex * @PageSize) ORDER By RowNum

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
