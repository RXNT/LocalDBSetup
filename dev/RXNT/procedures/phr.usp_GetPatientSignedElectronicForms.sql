SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Kalimuthu
Create date			:	23-January-2020
Description			:	This procedure is used to get patient signed electronic forms
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_GetPatientSignedElectronicForms]
	@PatientId			BIGINT
AS
BEGIN
	 SELECT ELECTRONIC_FORM_ID, PAT_ID, SRC_DR_ID, UPLOAD_DATE, TITLE ELC_TITLE, DESCRIPTION, FILENAME, TYPE FROM PATIENT_ELECTRONIC_FORMS 
     WHERE PAT_ID = @PatientId ORDER BY UPLOAD_DATE DESC, ELECTRONIC_FORM_ID DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
