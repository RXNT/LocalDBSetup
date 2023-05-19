SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	27-APR-2018
Description			:	This procedure is used to Delete Patient Active Med by Medication Id
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [hospice].[DeletePatientActiveMedication]	
	@ActiveMedicationId		BIGINT
AS
BEGIN
	DELETE FROM patient_active_meds 
	WHERE pam_id = @ActiveMedicationId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
