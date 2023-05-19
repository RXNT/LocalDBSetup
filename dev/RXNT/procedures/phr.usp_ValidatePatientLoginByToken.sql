SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram
-- Create date: 13-SEPT-2017
-- Description:	Validate Patient Login By Token
-- =============================================
CREATE PROCEDURE  [phr].[usp_ValidatePatientLoginByToken] 
(
	@DoctorCompanyId	BIGINT,
	@Signature			VARCHAR(900),
	@Token				VARCHAR(900),
	@IncludeAnyDoctor	BIT=NULL
)
AS
BEGIN
	SELECT  PL.pa_id AS LoginId,
			PL.pa_username AS Username,
			PL.salt,
			pl.pa_password,
			PL.signature,
			DC.dc_id AS CompanyId,
			DC.dc_name AS CompanyName,
			PL.passwordversion,
			ISNULL(P.pa_last,'') + ',' + ISNULL(' ' + P.pa_first,'') + COALESCE(' ' + P.pa_middle, '')  AS FullName,
			V2.PatientId AS V2PatientId,
			V2.CompanyId AS V2CompanyId,
			CASE WHEN @IncludeAnyDoctor=1 THEN (SELECT TOP 1 dr.dr_id FROM doctors dr WITH(NOLOCK) 
			INNER JOIN dbo.RsynRxNTMasterLoginExternalAppMaps MEAM WITH(NOLOCK) ON MEAM.ExternalAppId=1 AND MEAM.ExternalLoginId=dr.dr_id AND MEAM.ExternalCompanyId = DC.dc_id
			INNER JOIN dbo.RsynRxNTMasterLogins ML WITH(NOLOCK) ON MEAM.LoginId=ML.LoginId
			WHERE dr.dg_id=p.dg_id AND dr.dr_enabled=1 AND dr.prescribing_authority=4 AND ML.PasswordExpiryDate>GETDATE()  AND ML.Active = 1) ELSE NULL END AS DoctorId
	 FROM dbo.patient_login PL WITH(NOLOCK)
	 INNER JOIN dbo.patients P WITH(NOLOCK) ON PL.pa_id = P.pa_id 
	 INNER JOIN dbo.doc_groups DG WITH(NOLOCK) ON P.dg_id = DG.dg_id
	 INNER JOIN dbo.doc_companies DC WITH(NOLOCK) ON DC.dc_id = DG.dc_id 
	 INNER JOIN dbo.PatientTokens PT WITH(NOLOCK) ON PT.PatientId = PL.pa_id
	 LEFT OUTER JOIN dbo.RsynMasterPatientExternalAppMaps V2  WITH(NOLOCK) ON PL.pa_id = V2.ExternalPatientId AND V2.ExternalDoctorCompanyId=DC.dc_id AND V2.ExternalAppId=1
	 WHERE PL.signature = @Signature AND DC.dc_id = @DoctorCompanyId AND
		   PT.[Token] = @Token AND
		   PT.[TokenExpiryDate] > GETDATE() AND PT.Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
