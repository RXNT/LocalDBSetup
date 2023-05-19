SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	02-Nov-2017
Description			:	This procedure is used to Search Patient Past Hx Allergies for Patient Encounter
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [enc].[usp_SearchAllergiesForPatientEncounter]
	@Name VARCHAR(50),
	@MaxRows INT = 50
AS

BEGIN
	SET NOCOUNT ON;
	
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
