SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 08-Nov-2022
-- Description: Load Smoking Constants
-- =============================================
CREATE   PROCEDURE  [enc].[usp_PatientSmokingStatusConstants]
AS

BEGIN
SET NOCOUNT ON;

	SELECT ATC.Description,ATC.Code,SLC.Code as SNOMED
	from ehr.ApplicationTableConstants ATC WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATC.ApplicationTableId
	left join ehr.SysLookupCodes SLC WITH(NOLOCK) ON SLC.ApplicationTableConstantCode = ATC.Code  AND ATC.ApplicationTableConstantId = SLC.ApplicationTableConstantId
	WHERE AT.Code IN ('SMOKE')
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
