SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	19-Sep-2016
Description			:	This procedure is used to authenticate system user
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [aut].[usp_ValidateExternalLogin]
(
	@DoctorCompanyId	VARCHAR(100),
	@AppLoginId			VARCHAR(100),
	@ApplicationName			VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	 
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
