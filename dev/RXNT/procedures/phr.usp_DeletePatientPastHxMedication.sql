SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	VINOD
Create date			:	19-Feb-2018
Description			:	
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_DeletePatientPastHxMedication]	
	@PatientPastHxMedicationId		BIGINT,
	@PatientId   BIGINT
AS
BEGIN
	UPDATE ehr.PatientPastHxMedicationExternal 
	SET Active = 0
	WHERE PatientPastHxMedicationExtId = @PatientPastHxMedicationId and PatientId=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
