SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Load Search Application Constants
-- =============================================
CREATE PROCEDURE  [ehr].[usp_SearchApplicationConstants]
 	@Code			VARCHAR(5)
	
	
AS

BEGIN
SET NOCOUNT ON;

select DISTINCT C.CodeId,C.Description,AT.Code from ehr.SysLookupCodeSystem CS 
INNER JOIN  ehr.SysLookupCodes C ON C.CodeSystemId = CS.CodeSystemId
INNER JOIN ehr.ApplicationTableConstants ATS ON ATS.Code = C.ApplicationTableConstantCode AND C.ApplicationTableConstantId=ATS.ApplicationTableConstantId
INNER JOIN ehr.ApplicationTables AT ON AT.ApplicationTableId = ATS.ApplicationTableId
where AT.Code=@Code
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
