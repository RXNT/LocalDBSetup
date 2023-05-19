SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	30-JULY-2016
Description			:	This procedure is used to delete patient encounter
Last Modified By	:	Samip Neupane (Use added_by_dr_id instead of dr_id while getting encounters to delete)
Last Modifed Date	:	02-01-2023
=======================================================================================
*/

CREATE PROCEDURE [ehr].[usp_DeletePatientEncounter]	
	@EncounterId		BIGINT,
	@DoctorId	BIGINT
AS
BEGIN
	DELETE FROM ENCHANCED_ENCOUNTER 
	WHERE ENC_ID=@EncounterId AND ADDED_BY_DR_ID=@DoctorId AND ISSIGNED=0
	
	UPDATE patient_visit 
	SET ENC_ID = 0,chkout_notes='' 
	WHERE ENC_ID = @EncounterId AND DR_ID=@DoctorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
