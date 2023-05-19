SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	06-JUNE-2016
Description			:	This procedure is used to Get Patient Language Code
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[GetPatientLanguageCode]	
	@Code			VARCHAR(50)	
AS
BEGIN
	

SELECT PL.PreferredLanguageId FROM ehr.SysLookupCodes slc WITH(NOLOCK)
  INNER JOIN [dbo].[PreferredLanguages] PL WITH(NOLOCK) ON slc.ApplicationTableConstantCode = PL.Code
  INNER JOIN ehr.SysLookupCodeSystem slcs WITH(NOLOCK) ON slc.CodeSystemId=slcs.CodeSystemId
  WHERE slc.Code=@Code AND slcs.ApplicationTableCode='LANGU'

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
