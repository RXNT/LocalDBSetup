SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Shankar
-- Create date: 25-SEP-2018
-- Description:	This SP returns the User Name for Forgot Credetials 
-- =============================================
CREATE PROCEDURE [phr].[usp_GetUserDetailsForForgotUserCredentials] 
	@LastName VARCHAR(900) ,
	@Email VARCHAR(900) ,
	@DateOfBirth DATETIME,
	@UserType VARCHAR(50)
AS
BEGIN
   IF(@UserType = 'PATIENT')
BEGIN
    SELECT TOP 1 PAT.pa_id AS PatientId, PL.pa_username AS PatientUserName, PL.pa_email AS PatientEmail FROM  
    patients PAT WITH(NOLOCK)
	INNER JOIN [dbo].[patient_login] AS PL ON PAT.pa_id = PL.pa_id
	WHERE PAT.pa_last = @LastName 
	AND PAT.pa_email = @Email
	AND PAT.pa_dob = @DateOfBirth
	ORDER BY PAT.pa_id DESC
END


ELSE IF(@UserType = 'REPRESENTATIVE')
      BEGIN
         SELECT TOP 1 PR.PatientRepresentativeId AS PatientRepresentativeId, PRI.Text1 AS PatientRepresentativeUserName, PR.Email AS PatientEmail 
		 FROM  phr.PatientRepresentatives PR WITH(NOLOCK)
		 INNER JOIN   phr.PatientRepresentativesInfo AS PRI ON PR.PatientRepresentativeId = PRI.PatientRepresentativeId
		 WHERE PR.LastName = @LastName 
		 AND PR.Email = @Email
		 AND PR.DOB = @DateOfBirth
		 ORDER BY PR.PatientRepresentativeId DESC
END 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
