SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 10-May-2016
-- Description:	Save Patient Consent for the user
-- =============================================

CREATE PROCEDURE [ehr].[usp_SavePatientConsent]
	@PatientId BIGINT,
	@LoggedInUserId BIGINT,
	@ConsentOn DATETIME
AS
BEGIN
	IF NOT EXISTS(SELECT TOP 1 1 FROM patient_consent WITH(NOLOCK) WHERE pa_id = @PatientId AND  dr_id =@LoggedInUserId )
	BEGIN
		INSERT INTO patient_consent(pa_id, dr_id, date) 
		VALUES(@PatientId, @LoggedInUserId, @ConsentOn)
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
