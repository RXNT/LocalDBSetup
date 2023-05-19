SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 10-May-2016
-- Description:	Delete Patient Consent for the user
-- =============================================

CREATE PROCEDURE [ehr].[usp_DeletePatientConsent]
	@PatientId BIGINT,
	@LoggedInUserId BIGINT
AS
BEGIN
	DELETE
	FROM patient_consent
	WHERE pa_id =@PatientId AND dr_id = @LoggedInUserId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
