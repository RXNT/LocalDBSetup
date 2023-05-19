SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Balaji
Create date			:	08-Aug-2016
Description			:	This procedure is used to get applogin salt
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[usp_GetAppLoginSaltInfo]	
	@AppLoginId			BIGINT,
	@DoctorCompanyId	BIGINT	
AS
BEGIN
	SELECT AL.salt AS 'PasswordSALT',
			'' AS 'SsnSALT'
	FROM doctors AL WITH(NOLOCK)
		INNER JOIN doc_groups DG WITH(NOLOCK) ON AL.dg_id = DG.dg_id
	WHERE AL.dr_id			= @AppLoginId
		  AND DG.dc_id   = @DoctorCompanyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
