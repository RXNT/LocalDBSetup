SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	17-JUNE-2016
Description			:	This procedure is used to Save Patient Diagnosis
Last Modified By	:   JahabarYusuff M
Description			:	Remove id9 code from db save
Last Modifed Date	:	26-Oct-2022
=======================================================================================
*/
CREATE   PROCEDURE [ehr].[usp_SavePatientDiagnosis]	
	@PatientDiagnosisId		BIGINT,
	@PatientId				BIGINT,
	@ICD10					VARCHAR(100) = NULL,
	@ICD10Description		VARCHAR(255) = NULL,
	@SNOMED					VARCHAR(100) = NULL,
	@SNOMEDDescription		VARCHAR(255) = NULL,
	@RecordSource			VARCHAR(500) = NULL,
	@DateAdded				DATETIME,
	@OnSetDate				DATETIME = NULL,
	@DoctorId				BIGINT,
	@Status					TINYINT = NULL,
	@Severity				VARCHAR(50),
	@Type					SMALLINT,
	@StatusDate				DATETIME,
	@DiagnosisSequence		INT,
	@LastModifiedDate		DATETIME = NULL,
	@DiagnosisName          VARCHAR(255)

	
AS
BEGIN 
	IF @PatientDiagnosisId>0
	BEGIN
		UPDATE patient_active_diagnosis SET 
			enabled = @Status, 
			onset = @OnSetDate, 
			severity = @Severity, 
			icd9_description = @DiagnosisName, 
			type = @Type, 
			status = @Status, 
			status_date = @StatusDate, 
			date_added = @DateAdded,
			record_source = @RecordSource, 
			active = 1,
			icd10 = @ICD10,
			icd10_desc = @ICD10Description,
			snomed_code = @SNOMED,
			snomed_desc = @SNOMEDDescription,
			diagnosis_sequence = @DiagnosisSequence,
			last_modified_date = @LastModifiedDate
		WHERE pad = @PatientDiagnosisId AND pa_id = @PatientId
		SELECT @PatientDiagnosisId
	END
	ELSE
	BEGIN
		INSERT INTO patient_active_diagnosis 
		(
			pa_id,
			added_by_dr_id, 
			date_added, 
			enabled, 
			onset, 
			severity, 
			type, 
			status, 
			status_date, 
			record_source, 
			active,
			icd9_description,
			icd10,
			icd10_desc,
			snomed_code,
			snomed_desc,
			diagnosis_sequence,
			last_modified_date
		)
		VALUES 
		(
			@PatientId, 
			@DoctorId, 
			@DateAdded, 
			@Status,
			@OnSetDate, 
			@Severity, 
			@Type, 
			@Status, 
			@StatusDate, 
			@RecordSource, 
			1,
			@DiagnosisName,
			@ICD10,
			@ICD10Description,
			@SNOMED,
			@SNOMEDDescription,
			@DiagnosisSequence,
			@LastModifiedDate
		)
		SELECT SCOPE_IDENTITY()
    END      

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
