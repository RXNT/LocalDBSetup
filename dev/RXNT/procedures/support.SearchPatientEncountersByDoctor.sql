SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 02-FEB-2017
-- Description:	To Search Encounters under Provider
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [support].[SearchPatientEncountersByDoctor]
  @DoctorId BIGINT   
AS
BEGIN
	DECLARE @FromDate as DATETIME
	DECLARE @ToDate as DATETIME
	DECLARE @MinAge as INT
	DECLARE @MaxAge as INT
	SET @FromDate=convert(datetime, '2016-01-01',101)
	SET @ToDate=convert(datetime, '2016-12-31',101)
	SET @MinAge=18 
	SET @MaxAge=50 
	SELECT  pat.pa_id AS PatientId,pat.pa_first as PatientFirstName,pat.pa_last as PatientLastName,CONVERT(VARCHAR(20),pat.pa_dob,101) as PatientDOB,pat.pa_sex as Gender,CONVERT(INT,ROUND(DATEDIFF(hour,pat.pa_dob,GETDATE())/8766.0,0)) as Age 
	FROM patients pat	
	INNER JOIN enchanced_encounter ench_enc on pat.pa_id = ench_enc.patient_id
	INNER JOIN patient_active_diagnosis pad on pat.pa_id=pad.pa_id
	where ench_enc.dr_id = @DoctorId AND ench_enc.enc_date between @FromDate and @ToDate 
	AND  CONVERT(INT,ROUND(DATEDIFF(hour,pat.pa_dob,GETDATE())/8766.0,0)) between @MinAge and @MaxAge AND pad.icd10='M54.5' 
	GROUP BY pat.pa_dob,pat.pa_id,pat.pa_first,pat.pa_last,pat.pa_sex
END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
