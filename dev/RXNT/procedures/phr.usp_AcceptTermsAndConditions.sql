SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 29-Jun-2022
-- Description:	Set the accepted_terms_date for a patient or representative.
-- =============================================
CREATE PROCEDURE [phr].[usp_AcceptTermsAndConditions]
	@LoggedInUserId BIGINT,
	@UserType VARCHAR(15),
	@AcceptedTermsDate DATETIME
AS
BEGIN

	SET NOCOUNT ON;
	
	IF @UserType = 'PATIENT'
		UPDATE dbo.patient_login
		SET accepted_terms_date = @AcceptedTermsDate
		WHERE pa_id = @LoggedInUserId
	ELSE
		UPDATE phr.PatientRepresentatives
		SET accepted_terms_date = @AcceptedTermsDate
		WHERE PatientRepresentativeId = @LoggedInUserId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
