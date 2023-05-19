SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	21-JUNE-2016
Description			:	This procedure is used to Delete Patient med History
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_DeleteMedicationHistory]
	@PatientMedHxId BIGINT
AS
BEGIN
	DELETE FROM patient_medications_hx WHERE pam_id = @PatientMedHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
