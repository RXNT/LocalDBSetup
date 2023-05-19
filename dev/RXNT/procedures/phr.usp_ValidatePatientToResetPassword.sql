SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Shankar
-- Create date: 10-SEP-2018
-- Description:	This SP validates the given Patient Name and Email 
-- =============================================
CREATE PROCEDURE [phr].[usp_ValidatePatientToResetPassword] 
	@PatientEmail				VARCHAR(80),
 	@PatientName			VARCHAR(50),
	@UserType VARCHAR(50)
AS
IF(@UserType = 'PATIENT')
BEGIN
	
	SELECT TOP 1 PAT.pa_id, PAT.pa_last, PAT.pa_first, PAT.pa_email, DC.dc_name, DC.dc_id, PL.pa_username
	FROM patients PAT WITH(NOLOCK)
	INNER JOIN [dbo].[patient_login] PL ON PAT.pa_id=PL.pa_id
	INNER JOIN doc_groups DG WITH(NOLOCK) ON PAT.dg_id=DG.dg_id
	INNER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id=DC.dc_id
	WHERE PAT.pa_email = @PatientEmail AND (PL.pa_username = @PatientName)
	ORDER BY  PAT.pa_id DESC
END
ELSE IF(@UserType = 'REPRESENTATIVE')

BEGIN
    SELECT TOP 1 PR.PatientId , PR.PatientRepresentativeId, PR.LastName AS RepresentativeLastName, PR.FirstName AS RepresentativeFirstName, PR.Email, PRI.Text1,DC.dc_name, DC.dc_id
	FROM  phr.PatientRepresentatives PR WITH(NOLOCK)
	INNER JOIN phr.PatientRepresentativesInfo AS PRI WITH (NOLOCK) ON PR.PatientRepresentativeId = PRI.PatientRepresentativeId
	INNER JOIN patients PAT WITH (NOLOCK) ON PR.PatientId = PAT.pa_id
	INNER JOIN [dbo].[patient_login] PL ON PAT.pa_id=PL.pa_id
	INNER JOIN doc_groups DG WITH(NOLOCK) ON PAT.dg_id=DG.dg_id
	INNER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id=DC.dc_id
	WHERE PR.Email = @PatientEmail AND PRI.Text1 = @PatientName
	ORDER BY PR.PatientRepresentativeId DESC
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
