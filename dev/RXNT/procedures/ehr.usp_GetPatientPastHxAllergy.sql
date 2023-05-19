SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	20-OCT-2017
Description			:	This procedure is used to get Patient Past Hx Allergies
Last Modified By	:	12/14/2022
Last Modifed Date	:	Add allergy description to the select
=======================================================================================
*/
CREATE   PROCEDURE [ehr].[usp_GetPatientPastHxAllergy]	 
	@PatientPastHxAllergyId			BIGINT	
AS
BEGIN
	SELECT 
		PHxA.PatientPastHxAllergyId,
		PHxA.AllergyId,
		PHxA.Active, 
		PHxA.AllergyType, 
		PHxA.CreatedOn,
		PHxA.Reaction,
		PHxA.Comments, 
		case when (PHxA.SourceType = 'EXT' OR PHxA.AllergyId < 1) then PHxA.AllergyDescription else  b.dam_concept_id_desc end as dam_concept_id_desc, 
		PHxA.RecordSource, 
		PHxA.SourceType, 
		PHxA.PatientId,
		PHxA.AllergyDescription
	FROM [ehr].[PatientPastHxAllergies] PHxA WITH(NOLOCK) 
	LEFT JOIN rdamapm0 b WITH(NOLOCK) on PHxA.AllergyId = b.dam_concept_id and PHxA.AllergyType = b.dam_concept_id_typ 
	WHERE PHxA.PatientPastHxAllergyId = @PatientPastHxAllergyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
