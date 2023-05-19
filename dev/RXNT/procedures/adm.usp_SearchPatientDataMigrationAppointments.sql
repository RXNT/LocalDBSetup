SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 23-Mar-2015
-- Description	: to fetch patients data migration request
-- Modified By	: 
-- Modified Date:
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchPatientDataMigrationAppointments]
@dg_id AS BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT TOP 100 PAT.pa_id,PAT.dr_id FROM patients PAT  
	INNER JOIN [adm].[PatientDataMigrationRequests] SDMR WITH(NOLOCK) ON SDMR.dg_id = PAT.dg_id 
	LEFT OUTER JOIN [adm].[MigratedPatients] MA WITH(NOLOCK) ON MA.request_id = SDMR.request_id AND PAT.pa_id = MA.pa_id 
	WHERE SDMR.status = 1 AND  
	SDMR.migrated_on IS NULL AND 
	(MA.pa_id IS NULL  OR ISNULL(MA.retry_count,0)<3 AND MA.status=3) AND
	SDMR.dg_id=@dg_id  
 
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
