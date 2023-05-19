SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Vinod  
-- Create date: 03-April-2020
-- Description: Get Patient Allergies Details
-- =============================================  
  
CREATE PROCEDURE [fhir].[usp_SearchPatientAllergies]  
 @PatientId BIGINT

AS  
BEGIN  
	IF EXISTS(SELECT TOP 1 *FROM [patient_new_allergies] a WITH(NOLOCK)
		left join rdamapm0 b with(nolock)
		 on a.allergy_id = b.dam_concept_id and a.allergy_type = b.dam_concept_id_typ 
	 WHERE pa_id =@PatientId AND  case when (a.source_type = 'EXT' OR a.allergy_id < 1) 
											then a.allergy_description else  b.dam_concept_id_desc 
											end NOT IN ('No Known Allergies') )
	BEGIN
		 SELECT case when (a.source_type = 'EXT' OR a.allergy_id < 1) 
											then a.allergy_description else  b.dam_concept_id_desc 
											end as AllergyName
											,NULL  AllergyCode --323389000
											,a.pa_id PatientId,
											allergy_type 
		 FROM [patient_new_allergies] a WITH(NOLOCK)   
		 left join rdamapm0 b with(nolock)
		 on a.allergy_id = b.dam_concept_id and a.allergy_type = b.dam_concept_id_typ 
		 WHERE pa_id =@PatientId  AND  case when (a.source_type = 'EXT' OR a.allergy_id < 1) 
											then a.allergy_description else  b.dam_concept_id_desc 
											end NOT IN ('No Known Allergies')
	END
	ELSE
	BEGIN
		SELECT 'No Known Allergies' AllergyName,'716186003' as AllergyCode
											,@PatientId PatientId,
											1 allergy_type
	END
 
END  
  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
