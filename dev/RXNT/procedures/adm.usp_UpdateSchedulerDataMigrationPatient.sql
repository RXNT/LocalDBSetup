SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 23-Mar-2015
-- Description	: to update scheduler data migration request Patients
-- Modified By	: 
-- Modified Date:
-- =============================================
CREATE PROCEDURE [adm].[usp_UpdateSchedulerDataMigrationPatient]
@status AS INT,
@requestId AS BIGINT,
@patientid AS BIGINT,
@externalpatientid AS BIGINT
AS

BEGIN
	
	 IF EXISTS(SELECT TOP 1 1 FROM adm.MigratedPatients WHERE pa_id = @patientid AND request_id = @requestId) 
     BEGIN
          UPDATE adm.MigratedPatients SET status=@status,retry_count = retry_count+1, LastEditedOn = GETDATE(),ExternalPatientId = @externalpatientid WHERE pa_id = @patientid AND request_id = @requestId 
     END
     ELSE
     BEGIN
          INSERT INTO adm.MigratedPatients (pa_id,ExternalPatientId,request_id,status,retry_count,CreatedOn) 
          VALUES(@patientid,@externalpatientid,@requestId,@status,1, GETDATE()) 
     END 
 
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
