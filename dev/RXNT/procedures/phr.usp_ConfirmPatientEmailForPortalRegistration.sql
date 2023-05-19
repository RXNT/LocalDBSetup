SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-SEP-2018
-- Description: Confirm Patient Email for Portal Registration
-- =============================================
CREATE PROCEDURE  [phr].[usp_ConfirmPatientEmailForPortalRegistration]
 	@PatientEmail				VARCHAR(80),
 	@PatientLastName			VARCHAR(50),
 	@PatientDOB					DATETIME
AS
BEGIN
	DECLARE @EmailLogTypeId AS BIGINT=0
	
	SELECT TOP 1 @EmailLogTypeId=ISNULL(ATC.ApplicationTableConstantId,0)
	FROM ehr.ApplicationTableConstants ATC WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON ATC.ApplicationTableId=AT.ApplicationTableId
	WHERE AT.Code='PMTYP' AND ATC.Code='EMCNF'
	
	SELECT TOP 1 P.pa_id, P.pa_last, P.pa_first, P.pa_email, DC.dc_name, DC.dc_id, PR.pincode, PEL.Token
	FROM patients P WITH(NOLOCK)
	INNER JOIN doc_groups DG WITH(NOLOCK) ON P.dg_id=DG.dg_id
	INNER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id=DC.dc_id
	INNER JOIN patient_reg_db PR WITH(NOLOCK) ON P.pa_id=PR.pa_id
	INNER JOIN [phr].[PatientEmailLogs] PEL WITH(NOLOCK) ON P.pa_id=PEL.PatientId
	WHERE P.pa_email = @PatientEmail AND P.pa_last = @PatientLastName AND
	CONVERT(VARCHAR(20),P.pa_dob ,101) = CONVERT(VARCHAR(20),@PatientDOB,101)
	AND ISNULL(PR.active,0)=1 AND PEL.Type=@EmailLogTypeId AND PEL.Active=1
	ORDER BY  P.pa_id DESC, PR.date_created DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
