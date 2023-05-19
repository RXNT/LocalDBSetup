SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To get the patient allergies
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE   PROCEDURE [enc].[usp_SearchPatientAllergies]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT a.pa_allergy_id, 
		   a.allergy_id, 
		   a.status, 
		   a.allergy_type, 
		   a.add_date,
		   a.reaction_string,
		   a.reaction_snomed,
		   a.rxnorm_code,
		   a.allergy_snomed,
		   a.comments,
		   a.snomed_term,
		   CASE 
			WHEN (a.source_type = 'EXT' OR ISNULL(allergy_id,0) < 1) THEN a.allergy_description 
			ELSE  b.dam_concept_id_desc 
		   END AS dam_concept_id_desc,
		   a.record_source, 
		   a.source_type,
		   a.severity_id,
		   ATC.Description as severity_name, 
		   ATC.Code as severity_code
	FROM patient_new_allergies  a WITH(NOLOCK)
	LEFT JOIN rdamapm0 b WITH(NOLOCK) ON a.allergy_id = b.dam_concept_id AND a.allergy_type = b.dam_concept_id_typ
	LEFT JOIN ehr.ApplicationTableConstants ATC ON ATC.ApplicationTableConstantId = a.severity_id
	WHERE a.pa_id = @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
