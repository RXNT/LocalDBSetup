SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz 
Create date			:	20-OCT-2017
Description			:	This procedure is used to Delete Patient Allergies
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [enc].[usp_DeletePatientPastHxAllergyFrtomPatientEncounter]	
	@PatientPastHxAllergyId			BIGINT,
	@PatientId					BIGINT	
AS
BEGIN
	 DELETE FROM ehr.PatientPastHxAllergies
	 WHERE PatientId = @PatientId AND PatientPastHxAllergyId = @PatientPastHxAllergyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
