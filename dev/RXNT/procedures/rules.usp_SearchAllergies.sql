SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 14-MAR-2016
-- Description:	To search the allergies
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [rules].[usp_SearchAllergies] --'',100
	@Name VARCHAR(50)= NULL,
	@MaxRows INT = 50
AS

BEGIN
	SET NOCOUNT ON;
	SET @Name = ISNULL(@Name,'')
	
    SELECT DISTINCT TOP (@MaxRows) DAM_CONCEPT_ID,DAM_CONCEPT_ID_TYP, DAM_CONCEPT_ID_DESC ,at.allergy_type_desc
    FROM RDAMAPM0 WITH(NOLOCK)
    LEFT OUTER JOIN patient_allergy_type at  WITH(NOLOCK) ON DAM_CONCEPT_ID_TYP=at.allergy_type
    WHERE DAM_CONCEPT_ID_DESC LIKE '%'+@Name+'%'
    ORDER BY DAM_CONCEPT_ID_DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
