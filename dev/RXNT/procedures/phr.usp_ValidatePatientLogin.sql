SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description:	Validate Patient Login
-- Modified By: Ayja Weems
-- Modified Date: 22-Jun-2022
-- Last Modification: Return accepted_terms_date
-- =============================================
CREATE PROCEDURE  [phr].[usp_ValidatePatientLogin]
 @Username	Varchar(100)
AS
BEGIN
	SELECT PL.pa_id AS LoginId,PL.pa_username AS Username,PL.salt,P.dr_id,P.dg_id,
	pl.pa_password,PL.signature,DC.dc_id AS CompanyId, DC.dc_name AS CompanyName,PL.passwordversion
	,ISNULL(P.pa_last,'') + ',' + ISNULL(' ' + P.pa_first,'') + COALESCE(' ' + P.pa_middle, '')  AS FullName,
	PL.accepted_terms_date
	FROM dbo.patient_login PL WITH(NOLOCK)
	INNER JOIN dbo.patients P WITH(NOLOCK) ON PL.pa_id = P.pa_id 
	INNER JOIN dbo.doc_groups DG WITH(NOLOCK) ON P.dg_id = DG.dg_id
	INNER JOIN dbo.doc_companies DC WITH(NOLOCK) ON DC.dc_id = DG.dc_id 
	WHERE pa_username = @Username AND enabled=1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
