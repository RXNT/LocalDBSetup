SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vidya
Create date			:	06-Sep-2016
Description			:	This procedure is used to fetch marital statuses
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_GetMaritalStatuses]
(
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT
)
AS
BEGIN
	SELECT	MaritalStatusId, 
			Code, 
			Name,
			Description,
			SortOrder
	FROM	phr.MaritalStatuses WITH (NOLOCK)
	WHERE	Active = 1
	Order By SortOrder
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
