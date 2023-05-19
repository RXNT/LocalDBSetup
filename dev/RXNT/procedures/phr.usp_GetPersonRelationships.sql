SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vidya
Create date			:	29-Sep-2016
Description			:	This procedure is used to fetch list of person relationships
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_GetPersonRelationships]
(
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
   SELECT	PersonRelationshipId, 
			Code, 
			Name,
			Description,
			SortOrder
	FROM	phr.PersonRelationships WITH (NOLOCK) 
	WHERE	Active = 1
	Order By SortOrder
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
