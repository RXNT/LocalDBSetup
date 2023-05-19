SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	27-APR-2018
Description			:	This procedure is used to get patient active meds
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [hospice].[SearchPatientActiveMeds]	
	@PatientId			BIGINT	
AS
BEGIN
	
	SELECT DISTINCT PAM_ID
		FROM PATIENT_ACTIVE_MEDS A WITH(NOLOCK)
	WHERE A.PA_ID = @PatientId
	ORDER BY A.pam_id DESC
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
