SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SearchPatientAllergiesData]
	@PatientId			INT,
	@DoctorCompanyId	INT
AS
BEGIN
		select	a.reaction_string as reaction, 
				a.comments as comments, a.status as active,  
                case when (a.source_type = 'EXT' OR a.allergy_id < 1) 
                                    then a.allergy_description else  b.dam_concept_id_desc 
                                    end as allergy                                   
			FROM patient_new_allergies  a WITH(NOLOCK) 
			left join rdamapm0 b WITH(NOLOCK) on a.allergy_id = b.dam_concept_id and a.allergy_type = b.dam_concept_id_typ 	
			INNER JOIN patients p WITH(NOLOCK) ON p.pa_id = a.pa_id		
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = p.dg_id						
			WHERE dg.dc_id = @DoctorCompanyId AND a.pa_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
