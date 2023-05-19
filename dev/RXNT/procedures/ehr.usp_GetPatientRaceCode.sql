SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	06-JUNE-2016
Description			:	This procedure is used to Get Patient Race Code
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[usp_GetPatientRaceCode]	
	@Code			VARCHAR(50)	
AS
BEGIN
	
select SLC.ApplicationTableConstantCode from ehr.ApplicationTables AT
INNER JOIN ehr.ApplicationTableConstants ATC ON ATC.ApplicationTableId =AT.ApplicationTableId
INNER JOIN ehr.SysLookupCodes SLC ON SLC.ApplicationTableConstantCode = ATC.Code
where AT.Code='PARCA' and SLC.Code = @Code	

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
