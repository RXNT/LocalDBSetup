SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	21-JUNE-2016
Description			:	This procedure is used to Delete Patient Allergies
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_DeleteAllergies]	
	@PatientAllergyId			BIGINT,
	@PatientId					BIGINT	
AS
BEGIN
	 DELETE FROM patient_new_allergies WHERE PA_ID= @PatientId AND pa_allergy_id = @PatientAllergyId
 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
