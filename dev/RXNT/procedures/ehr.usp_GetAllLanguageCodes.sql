SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vidya
Create date			:	12-DEC-2017
Description			:	This procedure is used to Get all Language Code
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[usp_GetAllLanguageCodes]
AS
BEGIN
	

SELECT Distinct PL.PreferredLanguageId, PL.Name As PreferredLanguageName,
		PL.Code As PreferredLanguageCode,
		slc.Code As SysLookupCode, slc.Description As SysLookupDescription 
FROM	ehr.SysLookupCodes slc WITH(NOLOCK)
		INNER JOIN [dbo].[PreferredLanguages] PL WITH(NOLOCK) ON slc.ApplicationTableConstantCode = PL.Code
		INNER JOIN ehr.SysLookupCodeSystem slcs WITH(NOLOCK) ON slc.CodeSystemId=slcs.CodeSystemId
WHERE	slcs.ApplicationTableCode='LANGU'

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
