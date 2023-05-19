SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	15-Feb-2018
Description			:	This procedure is used to Search Patient Past Hx Allergies External
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_SearchPatientPastHxAllergiesExternal]	
	@PatientId			BIGINT,	
	@DoctorCompanyId    BIGINT
AS
BEGIN
	SELECT 
		PHxA.PatientPastHxAllergyExtId,
		PHxA.AllergyId,
		PHxA.Active, 
		PHxA.AllergyType, 
		PHxA.CreatedOn,
		PHxA.Reaction,
		PHxA.Comments, 
		case when (PHxA.SourceType = 'EXT' OR   ISNULL(PHxA.AllergyId,0) < 1 ) then PHxA.AllergyDescription else  b.dam_concept_id_desc end as dam_concept_id_desc, 
		PHxA.RecordSource, 
		PHxA.SourceType, 
		PHxA.PatientId,
        PHxA.rxnorm_code,
        PHxA.reaction_snomed,
        PHxA.allergy_snomed,
        PHxA.visibility_hidden_to_patient
	FROM [ehr].[PatientPastHxAllergiesExternal] PHxA WITH(NOLOCK) 
	LEFT JOIN rdamapm0 b WITH(NOLOCK) on PHxA.AllergyId = b.dam_concept_id and PHxA.AllergyType = b.dam_concept_id_typ 
	WHERE PHxA.PatientId = @PatientId
	ORDER BY PHxA.PatientPastHxAllergyExtId DESC
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
