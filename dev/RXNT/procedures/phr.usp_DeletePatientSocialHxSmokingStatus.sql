SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 31-OCT-2016
-- Description:	To get the patient Social Hx Smoking Status
-- =============================================
CREATE PROCEDURE [phr].[usp_DeletePatientSocialHxSmokingStatus]
	@PatientId BIGINT,
	@PatientSmokingStatusDetailExtId BIGINT
AS

BEGIN
	--DELETE FROM patient_flag_details WHERE  pa_id=@PatientId AND pa_flag_id=@PatientFlagDetailId
	UPDATE ehr.PatientSmokingStatusDetailExternal SET ACTIVE = 0  WHERE PatientId=@PatientId AND PatientSmokingStatusDetailExtId=@PatientSmokingStatusDetailExtId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
