SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 10-May-2016
-- Description:	Get Patient Consent for the user
-- =============================================

CREATE PROCEDURE [ehr].[usp_GetPatientConsent]
	@PatientId BIGINT,
	@LoggedInUserId BIGINT
AS
BEGIN
	SELECT TOP 1 pa_id, dr_id, date 
	FROM patient_consent WITH(NOLOCK) 
	WHERE pa_id =@PatientId AND dr_id = @LoggedInUserId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
