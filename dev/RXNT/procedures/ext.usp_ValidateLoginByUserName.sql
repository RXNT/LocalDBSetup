SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	05-May-2022
Description			:	This procedure is used to authenticate system user
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE   PROCEDURE [ext].[usp_ValidateLoginByUserName]
(
	@UserName	VARCHAR(250)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT AL.dr_id As AppLogInId, 
		   DG.dg_id As DoctorGroupId, 
		   DG.dc_id As DoctorCompanyId,
		   AL.dr_username AS UserName,
		   ISNULL(AL.dr_last_name,'') + ', ' + ISNULL(AL.dr_first_name,'') + ' '	+ ISNULL(AL.dr_middle_initial,'') As FullName,
		   '' As [Signature],
		   AL.dr_password AS Text2,
		   AL.salt AS Text4
	FROM [doctors]		AL		WITH(NOLOCK)
	INNER JOIN [doc_groups] DG WITH(NOLOCK) ON AL.dg_id = DG.dg_id
	WHERE  AL.dr_username = @UserName ;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
