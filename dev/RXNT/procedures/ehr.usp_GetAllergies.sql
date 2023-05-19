SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
 =======================================================================================
 Author:        Rama Krishna
 Create date:   20-JUNE-2016
 Description:   This procedure is used to get Patient Allergies
 Modified By:   Samip Neupane
 Modified Date: 03/14/2023
 Description:   Add visibility_hidden_to_patient to the select
 =======================================================================================
 */
CREATE   PROCEDURE [ehr].[usp_GetAllergies] 
  @PatientAllergyId BIGINT
AS
BEGIN
	SELECT a.pa_allergy_id,
		a.allergy_id,
		a.STATUS,
		a.allergy_type,
		a.add_date,
		a.reaction_string,
		a.comments,
		CASE 
			WHEN (
					a.source_type = 'EXT'
					OR ISNULL(allergy_id, 0) < 1
					)
				THEN a.allergy_description
			ELSE b.dam_concept_id_desc
			END AS dam_concept_id_desc,
		a.record_source,
		a.source_type,
		a.severity_id,
		ATC.Description AS severity_name,
		a.rxnorm_code,
		a.last_modified_date,
		a.reaction_snomed,
		a.allergy_snomed,
		a.snomed_term,
		a.visibility_hidden_to_patient
	FROM patient_new_allergies a WITH (NOLOCK)
	LEFT JOIN rdamapm0 b WITH (NOLOCK) ON a.allergy_id = b.dam_concept_id
		AND a.allergy_type = b.dam_concept_id_typ
	LEFT JOIN ehr.ApplicationTableConstants ATC ON ATC.ApplicationTableConstantId = a.severity_id
	WHERE a.pa_allergy_id = @PatientAllergyId;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
