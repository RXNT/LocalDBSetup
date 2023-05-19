SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description:	Validate Patient Login
-- =============================================
CREATE PROCEDURE  [dbo].[usp_ValidatePatientLogin]
 @Username	Varchar(100)
AS
BEGIN
	select PL.pa_id as LoginId,PL.pa_username as Username,PL.salt,
	pl.pa_password,PL.signature,DC.dc_id as CompanyId,PL.passwordversion
	,ISNULL(P.pa_last,'') + ',' + ISNULL(' ' + P.pa_first,'') + COALESCE(' ' + P.pa_middle, '')  As FullName
	 from dbo.patient_login PL with(nolock)
	 INNER JOIN dbo.patients P ON PL.pa_id = P.pa_id 
	 INNER JOIN dbo.doc_groups DG ON P.dg_id = DG.dg_id
	 INNER JOIN dbo.doc_companies DC ON DC.dc_id = DG.dc_id 
	 where pa_username = @Username
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
