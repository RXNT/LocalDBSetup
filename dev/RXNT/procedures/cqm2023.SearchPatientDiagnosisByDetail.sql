SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Patient Diagnosis by detail
-- =============================================
CREATE    PROCEDURE [cqm2023].[SearchPatientDiagnosisByDetail]
  @PatientId			BIGINT,
  @SNOMEDCode			VARCHAR(30),
  @ICD10Code			VARCHAR(30),
  @ICD9Code				VARCHAR(30),
  @ICD9Desc				VARCHAR(30),
  @ICD10Desc			VARCHAR(30),
  @DoctorId				BIGINT,
  @StatusDate			DATETIME=NULL,
  @DateAdded			DATETIME=NULL,
  @OnSetDate			DATETIME=NULL,
  @Status				VARCHAR(50),
  @Name					VARCHAR(30)
AS
BEGIN
	DECLARE @DiagId AS BIGINT=0
	
	SELECT @DiagId=ISNULL(pad,0) FROM patient_active_diagnosis 
	WHERE pa_id=@PatientId AND added_by_dr_id=@DoctorId AND snomed_code=@SNOMEDCode AND icd10=@ICD10Code AND icd10_desc=@ICD10Desc AND 
	icd9=@ICD9Code AND icd9_desc=@ICD9Desc AND CONVERT(VARCHAR(10), status_date, 101)=@StatusDate AND CONVERT(VARCHAR(10), date_added, 101)=@DateAdded AND CONVERT(VARCHAR(10), onset, 101)=@OnSetDate AND status=@Status AND
	active=1 AND icd9_description=@Name
	
	SELECT @DiagId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
