SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	28-November-2017
Description			:	Validate patient login by patient id.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE  [phr].[usp_ValidatePatientLoginById]
    @PatientId	BIGINT
AS
BEGIN
	SELECT PL.pa_id AS LoginId,PL.pa_username AS Username,PL.salt,P.dr_id,P.dg_id,
	pl.pa_password,PL.signature,DC.dc_id AS CompanyId, DC.dc_name AS CompanyName,PL.passwordversion
	,ISNULL(P.pa_last,'') + ',' + ISNULL(' ' + P.pa_first,'') + COALESCE(' ' + P.pa_middle, '')  AS FullName
	FROM dbo.patient_login PL WITH(NOLOCK)
	INNER JOIN dbo.patients P WITH(NOLOCK) ON PL.pa_id = P.pa_id 
	INNER JOIN dbo.doc_groups DG WITH(NOLOCK) ON P.dg_id = DG.dg_id
	INNER JOIN dbo.doc_companies DC WITH(NOLOCK) ON DC.dc_id = DG.dc_id 
	WHERE PL.pa_id = @PatientId AND enabled=1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
