SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CheckPatientDiagnosisExists]
/* 
	EXEC [support].[CheckPatientDiagnosisExists] 
	@RxNTPatientId =  <Enter RxNT Patient Id here>,		-- Required
	@Diagnosis =  '<Enter diagnosis name here>'			-- Optional
	GO
*/
@RxNTPatientId BIGINT, 
@Diagnosis VARCHAR(100)=NULL 
AS
	 
	SELECT pad.pad RxNTPatientDiagnosisId, pad.icd9_description Diagnosis, pad.icd10 ICD10, pad.icd10_desc ICD10Description,pad.snomed_code SNOMED, pad.snomed_desc SNOMEDDescription, doc.dr_first_name DoctorFirstName,  doc.dr_last_name DoctorLastName, 
	pad.date_added DateAdded, CONVERT(VARCHAR(20),pad.onset,101) OnsetDate, pad.severity Severity, pad.record_source RecordSource,CONVERT(VARCHAR(20), pad.status_date,101) StatusDate, pad.last_modified_date LastModifiedOn
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	LEFT OUTER join doctors doc WITH(NOLOCK) ON pad.added_by_dr_id = doc.dr_id 
	WHERE pad.pa_id = @RxNTPatientId 
	AND (@Diagnosis IS NULL OR pad.icd9_description = @Diagnosis+'%')
	ORDER BY pad.diagnosis_sequence, pad.pad DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
