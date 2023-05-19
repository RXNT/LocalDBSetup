SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/13/2022
-- Description:	Get Patient Diagnosis from the Diagnosis Id
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPatientDiagnosis]
	-- Add the parameters for the stored procedure here
	@PatientDiagnosisId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT 
		pad.pad,
		pad.icd9_description,
		pad.icd9,
		pad.icd9_desc,
		pad.icd10,
		pad.icd10_desc,
		pad.snomed_code,
		pad.snomed_desc,
		doc.dr_first_name,
		pad.type,
		doc.dr_last_name,
		pad.date_added,
		pad.enabled,
		pad.onset,
		pad.severity,
		pad.record_source,
		pad.status_date,
		pad.diagnosis_sequence,
		pad.last_modified_date
	FROM patient_active_diagnosis pad WITH (NOLOCK)
	LEFT JOIN doctors doc WITH (NOLOCK) ON pad.added_by_dr_id = doc.dr_id
	WHERE pad.pad = @PatientDiagnosisId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
