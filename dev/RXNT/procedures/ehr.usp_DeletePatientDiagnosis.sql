SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	17-JUNE-2016
Description			:	This procedure is used to Delete Patient Diagnosis
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_DeletePatientDiagnosis]	
	@PatientDiagnosisId		BIGINT,
	@PatientId				BIGINT
AS
BEGIN
	DELETE FROM patient_active_diagnosis 
	WHERE PA_ID = @PatientId AND PAD = @PatientDiagnosisId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
