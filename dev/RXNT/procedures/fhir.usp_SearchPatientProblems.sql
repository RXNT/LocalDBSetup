SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
-- =============================================  
-- Author:  Vinod  
-- Create date: 03-April-2020
-- Description: Get Patient Condition Details
-- =============================================  
  
CREATE PROCEDURE [fhir].[usp_SearchPatientProblems]  --65639803
 @PatientId BIGINT

AS  
BEGIN  
	DECLARE @PatientFirstName VARCHAR(50)
	DECLARE @PatientMiddleName VARCHAR(50)
	DECLARE @PatientLastName VARCHAR(50)
	
	SELECT @PatientFirstName=pa_first,@PatientMiddleName=pa_middle,@PatientLastName=pa_last
	FROM patients pat WITH(NOLOCK) 
	WHERE pat.pa_id=@PatientId
	
	SELECT pad.icd9_description,pad.icd9, pad.snomed_code,pad.icd10
	,pad.pa_id PatientId
	,@PatientFirstName PatientFirstName
	,@PatientMiddleName PatientMiddleName
	,@PatientLastName PatientLastName
	FROM patient_active_diagnosis pad WITH(NOLOCK)
	LEFT OUTER join doctors doc WITH(NOLOCK) ON pad.added_by_dr_id = doc.dr_id 
	WHERE pad.pa_id = @PatientId
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
