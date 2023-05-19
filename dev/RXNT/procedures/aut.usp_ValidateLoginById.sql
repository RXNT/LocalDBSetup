SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	19-Oct-2017
Description			:	This procedure is used to authenticate system user
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [aut].[usp_ValidateLoginById]
(
	@DoctorCompanyId	VARCHAR(100),
	@AppLoginId			VARCHAR(100)
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
	ELSE IF @AppLoginId = -1
	BEGIN
		SELECT TOP 1 
			@AppLoginId			= DR.dr_id
		FROM doc_companies		DC WITH(NOLOCK) 
		INNER JOIN doc_groups	DG WITH(NOLOCK) ON DC.dc_id = DG.dc_id
		INNER JOIN doctors		DR WITH(NOLOCK) ON DG.dg_id = DR.dg_id
		WHERE DG.dc_id = @DoctorCompanyId 
	END
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
	WHERE DG.dc_id = @DoctorCompanyId 
		  AND AL.dr_id = @AppLoginId ;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
