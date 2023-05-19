SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rajaram
-- Create date: 13-SEPT-2017
-- Description:	Validate Patient Login By Token
-- =============================================
CREATE PROCEDURE  [dbo].[usp_ValidatePatientLoginByToken]
(
	@DoctorCompanyId	BIGINT,
	@Signature			VARCHAR(900),
	@Token				VARCHAR(900)
)
AS
BEGIN
	select  PL.pa_id as LoginId,
			PL.pa_username as Username,
			PL.salt,
			pl.pa_password,
			PL.signature,
			DC.dc_id as CompanyId,
			PL.passwordversion,
			ISNULL(P.pa_last,'') + ',' + ISNULL(' ' + P.pa_first,'') + COALESCE(' ' + P.pa_middle, '')  As FullName
	 from dbo.patient_login PL with(nolock)
	 INNER JOIN dbo.patients P ON PL.pa_id = P.pa_id 
	 INNER JOIN dbo.doc_groups DG ON P.dg_id = DG.dg_id
	 INNER JOIN dbo.doc_companies DC ON DC.dc_id = DG.dc_id 
	 INNER JOIN dbo.PatientTokens PT ON PT.PatientId = PL.pa_id
	 where PL.signature = @Signature AND DC.dc_id = @DoctorCompanyId AND
		   PT.[Token] = @Token AND
		   PT.[TokenExpiryDate] > GETDATE() AND PT.Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
