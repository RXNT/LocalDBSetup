SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 4/3/2018
-- Description:	To get the patient diagnosis
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [rules].[usp_SearchPatientDiagnosis]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT pad.pad, pad.icd9_description,pad.icd9, pad.icd9_desc, pad.icd10, pad.icd10_desc,pad.snomed_code, pad.snomed_desc, doc.dr_first_name, pad.type, doc.dr_last_name, 
	pad.date_added,pad.enabled, pad.onset, pad.severity, pad.record_source, pad.status_date, pad.diagnosis_sequence,pad.last_modified_date
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	LEFT OUTER join doctors doc WITH(NOLOCK) ON pad.added_by_dr_id = doc.dr_id 
	WHERE pad.pa_id = @PatientId
	ORDER BY pad.diagnosis_sequence, pad.pad DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
