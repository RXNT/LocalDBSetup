SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod 
Create date			:	7-Feb-2017
Description			:	This procedure is used to Delete Patient Allergies
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_DeletePatientPastHxAllergyExternal]	
	@PatientPastHxAllergyId			BIGINT,
	@PatientId					BIGINT	
AS
BEGIN
	 UPDATE ehr.PatientPastHxAllergiesExternal
	 SET Active = 0
	 WHERE PatientId = @PatientId AND PatientPastHxAllergyExtId = @PatientPastHxAllergyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
