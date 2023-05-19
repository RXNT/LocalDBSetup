SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Shankar
-- Create date: 19-SEP-2018
-- Description: This SP gets the Patient Information based on Id , this is maintained only for Forget Password Flow
-- =============================================
CREATE PROCEDURE [phr].[usp_GetPatientDetailsResetPassword] 
		@EmailToken VARCHAR(900)
AS
BEGIN
	 SELECT TOP 1  PL.pa_username AS PatientUserName, PEL.PatientId AS PatientId, PEL.DoctorCompanyId ,PRI.Text1 , PEL.PatientRepresentativeId
	 FROM [phr].[PatientEmailLogs] PEL WITH(NOLOCK)
	 INNER JOIN patients PT WITH(NOLOCK) ON PEL.PatientId = PT.pa_id
	 INNER JOIN  [dbo].[patient_login] PL WITH(NOLOCK ) ON  PT.pa_id = PL.pa_id
	 LEFT JOIN phr.PatientRepresentativesInfo PRI WITH (NOLOCK) ON  PEL.PatientRepresentativeId = PRI.PatientRepresentativeId
	 WHERE Token = @EmailToken AND enabled = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
