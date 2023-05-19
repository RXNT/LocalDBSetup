SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	14-Mar-2018
Description			:	This procedure is used to Search Patient Allergies

=======================================================================================
*/
CREATE PROCEDURE [rules].[usp_SearchPatientAllergies]	
	@PatientId			BIGINT	
AS
BEGIN
	select a.pa_allergy_id, a.allergy_id, a.status, a.allergy_type, a.add_date,
                                    a.reaction_string, a.comments, 
                                    case when (a.source_type = 'EXT' OR a.allergy_id < 1) 
                                    then a.allergy_description else  b.dam_concept_id_desc 
                                    end as dam_concept_id_desc, 
                                    a.record_source, a.source_type, 
                                    a.pa_id, a.severity_id, ATC.Description as severity_name,
                                    a.rxnorm_code,a.last_modified_date
 from patient_new_allergies  a with(nolock) 
 left join rdamapm0 b with(nolock) on a.allergy_id = b.dam_concept_id and a.allergy_type = b.dam_concept_id_typ 
 left join ehr.ApplicationTableConstants ATC on ATC.ApplicationTableConstantId = a.severity_id
 where 1=1 and a.pa_id = @PatientId
 ORDER BY a.pa_allergy_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
