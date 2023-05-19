SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	JahabarYusuff
Create date			:	06-SEPT-2019
Description			:	This procedure is to remove the phr regitration from the Db
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [support].[ResetPHRLinkforthePatient]
	@DoctorCompanyId		BIGINT,
	@PatientId				BIGINT
AS
BEGIN

	UPDATE [phr].[PatientEmailLogs]  SET PatientId = -1
	WHERE PatientId=@PatientId AND DoctorCompanyId=@DoctorCompanyId AND
			Active=1 		
			
	UPDATE [patient_phr_access_log] SET pa_id = -1
	WHERE pa_id=@PatientId 
	
	UPDATE [patient_login] SET pa_id = -1
	WHERE pa_id=@PatientId 
	
	
	-- @TODO Patient Portal Documents


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
