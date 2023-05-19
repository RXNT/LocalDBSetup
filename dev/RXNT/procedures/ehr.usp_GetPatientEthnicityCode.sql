SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	06-JUNE-2016
Description			:	This procedure is used to Get Patient Ethnicity Code
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetPatientEthnicityCode]	
	@Code			VARCHAR(50),
	@ParentId		VARCHAR(50) = NULL
AS
BEGIN

		select  PE.PARENT_ETHNICITY_ID,ATC.ApplicationTableConstantId  from ehr.ApplicationTables AT
		INNER JOIN ehr.ApplicationTableConstants ATC ON ATC.ApplicationTableId =AT.ApplicationTableId
		INNER JOIN ehr.SysLookupCodes SLC ON SLC.ApplicationTableConstantCode = ATC.Code
		INNER JOIN ehr.PatientEthnicityLookUpTable PE ON SLC.ApplicationTableConstantCode = PE.ETHNICITY_ID
		where AT.Code='PAETH' and SLC.Code = @Code	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
