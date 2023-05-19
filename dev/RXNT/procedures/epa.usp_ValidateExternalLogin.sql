SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rajaram
Create date			:	17-JUN-2016
Description			:	This procedure is used to authenticate external system user
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [epa].[usp_ValidateExternalLogin]
(
	@DoctorCompanyId	VARCHAR(100),
	@AppLoginId			VARCHAR(100),
	@ApplicationName			VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	IF @DoctorCompanyId = -1
	BEGIN
		SELECT TOP 1 
			@DoctorCompanyId	= dc.dc_id, 
			@AppLoginId			= DR.dr_id
		FROM doc_companies		DC WITH(NOLOCK) 
		INNER JOIN doc_groups	DG WITH(NOLOCK) ON DC.dc_id = DG.dc_id
		INNER JOIN doctors		DR WITH(NOLOCK) ON DG.dg_id = DR.dg_id
	END
	SELECT AL.dr_id As AppLogInId, 
		   DG.dg_id As DoctorGroupId, 
		   DG.dc_id As DoctorCompanyId,
		   AL.dr_username AS UserName,
		   ISNULL(AL.dr_last_name,'') + ', ' + ISNULL(AL.dr_first_name,'') + ' '	+ ISNULL(AL.dr_middle_initial,'') As FullName,
		   '' As [Signature]
	FROM [doctors]		AL		WITH(NOLOCK)
	INNER JOIN [doc_groups] DG WITH(NOLOCK) ON AL.dg_id = DG.dg_id
	WHERE DG.dc_id = @DoctorCompanyId 
		  AND AL.dr_id = @AppLoginId ;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
