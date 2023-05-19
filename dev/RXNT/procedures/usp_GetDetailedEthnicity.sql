SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod Kumar
Create date			:	11-17-2017
Description			:	This procedure is used to Get Detailed Ethnicity
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_GetDetailedEthnicity]	
	

AS
BEGIN
		SELECT DISTINCT ATC.Code,PR.PARENT_ETHNICITY_ID as ParentCode,[ATC].[Description],ATC.[ApplicationTableConstantId]
		FROM ehr.PatientEthnicityLookUpTable PR WITH(NOLOCK)
		INNER JOIN ehr.SysLookupCodes SLC WITH(NOLOCK) ON SLC.Code = PR.ETHNICITY_ID
		INNER JOIN[ehr].[ApplicationTableConstants] ATC WITH(NOLOCK) ON PR.ETHNICITY_ID= ATC.Code
		INNER JOIN[ehr].[ApplicationTables] AT WITH(NOLOCK) ON  AT.ApplicationTableId = ATC.ApplicationTableId AND AT.Code = 'PAETH'
		where PR.PARENT_ETHNICITY_ID = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
