SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vidya
Create date			:	06-Mar-2016
Description			:	This procedure is used to fetch phone preference types
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_GetPhonePreferenceTypes]
(
	@DoctorCompanyId BIGINT,
	@LoggedInuserId BIGINT
)
AS
BEGIN
	SELECT	PhonePreferenceTypeId, 
			Code, 
			Name,
			Description,
			SortOrder
	FROM	phr.PhonePreferenceTypes WITH (NOLOCK)
	WHERE	Active = 1
	Order By SortOrder
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
