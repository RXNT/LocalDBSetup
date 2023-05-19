SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Balaji
Create date			:	08-Aug-2016
Description			:	This procedure is used to user information based on token
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[usp_GetUserInfoByToken]
(
	@DoctorCompanyId	BIGINT,
	@Signature			VARCHAR(900),
	@Token				VARCHAR(900)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ALT.[AppLoginTokenId],
	   ALT.[Token],
	   ALT.[TokenExpiryDate],
	   AL.dr_id As AppLoginId
	FROM [doctors] AL					WITH(NOLOCK)
	INNER JOIN	[doc_groups] DG	WITH(NOLOCK) ON AL.dg_id	= DG.dg_id
	INNER JOIN	[doc_companies] DCMP	WITH(NOLOCK) ON DG.dc_id = DCMP.dc_id 
	INNER JOIN	[prv].[AppLoginTokens]	ALT		WITH(NOLOCK) ON ALT.AppLogInId		= AL.dr_id
	WHERE DCMP.dc_id = @DoctorCompanyId	AND
		  --ALI.[Signature] = @Signature			AND 
		  ALT.[Token] = @Token AND
		  ALT.[TokenExpiryDate] > GETDATE() AND ALT.Active = 1	
			
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
