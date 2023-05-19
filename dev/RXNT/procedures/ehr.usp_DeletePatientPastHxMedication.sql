SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	23-OCT-2017
Description			:	
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_DeletePatientPastHxMedication]	
	@PatientPastHxMedicationId		BIGINT,
	@PatientId   BIGINT
AS
BEGIN
	DELETE FROM PatientPastHxMedication 
	WHERE PatientPastHxMedicationId = @PatientPastHxMedicationId and PatientId=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
