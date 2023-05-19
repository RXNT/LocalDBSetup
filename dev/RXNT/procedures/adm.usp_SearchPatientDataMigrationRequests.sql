SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 28-Jul-2015
-- Description	: to fetch patient data migration requests
-- Modified By	: 
-- Modified Date:
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchPatientDataMigrationRequests]

AS

BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO [adm].[PatientDataMigrationRequests]
           ([dc_id]
           ,[dg_id]
           ,[ApplicationID]
           ,[reuested_on]
           ,[status])
    SELECT DG.dc_id,DG.dg_id,DGAM.ApplicationID,GETDATE(),1 FROM doc_group_application_map DGAM 
    INNER JOIN Applications A ON DGAM.ApplicationID = A.ApplicationID
    INNER JOIN ApplicationTypes AT ON A.ApplicationTypeID = AT.ApplicationTypeID
    INNER JOIN doc_groups DG ON DGAM.dg_id = DG.dg_id 
    LEFT OUTER JOIN [adm].[PatientDataMigrationRequests] PDMR ON DGAM.dg_id = PDMR.dg_id AND DGAM.ApplicationID = PDMR.ApplicationID AND DG.dc_id = PDMR.dc_id
    WHERE PDMR.request_id IS NULL AND AT.ApplicationTypeName IN ('Scheduler','PM')


	SELECT request_id, dc_id, dg_id, PDMR.ApplicationID, AT.ApplicationTypeID, reuested_on, migrated_on, status
	FROM  [adm].[PatientDataMigrationRequests] PDMR
	INNER JOIN Applications A ON PDMR.ApplicationID = A.ApplicationID
    INNER JOIN ApplicationTypes AT ON A.ApplicationTypeID = AT.ApplicationTypeID
	WHERE PDMR.status = 1 AND 
	PDMR.migrated_on IS NULL
 
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
