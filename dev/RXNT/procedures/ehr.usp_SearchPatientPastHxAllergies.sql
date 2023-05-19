SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	20-OCT-2017
Description			:	This procedure is used to Search Patient Past Hx Allergies
Modified By         :   JahabarYusuff M
Modified Date       :   05-Dec-2022
Description         :   Load allergy and reaction snomed
=======================================================================================
*/
 CREATE   PROCEDURE [ehr].[usp_SearchPatientPastHxAllergies]	
	@PatientId			BIGINT,	
	@DoctorCompanyId    BIGINT
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
		case when (PHxA.SourceType = 'EXT' OR ISNULL(PHxA.AllergyId,0) < 1) then PHxA.AllergyDescription else  b.dam_concept_id_desc end as dam_concept_id_desc, 
		PHxA.RecordSource, 
		PHxA.SourceType, 
		PHxA.PatientId,
		PHxA.rxnorm_code,
		PHxA.reaction_snomed,
		PHxA.allergy_snomed,
		PHxA.snomed_term, PHxA.visibility_hidden_to_patient

	FROM [ehr].[PatientPastHxAllergies] PHxA WITH(NOLOCK) 
	LEFT JOIN rdamapm0 b WITH(NOLOCK) on PHxA.AllergyId = b.dam_concept_id and PHxA.AllergyType = b.dam_concept_id_typ 
	WHERE PHxA.PatientId = @PatientId
	ORDER BY PHxA.PatientPastHxAllergyId DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
