SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 23-Mar-2015
-- Description	: to update scheduler data migration request appointments
-- Modified By	: 
-- Modified Date:
-- =============================================
CREATE PROCEDURE [adm].[usp_UpdateSchedulerDataMigrationAppointment]
@status AS INT,
@requestId AS BIGINT,
@appointmentId AS BIGINT,
@externalAppointmentId AS BIGINT
AS

BEGIN
	
	 IF EXISTS(SELECT TOP 1 1 FROM adm.MigratedAppointments WHERE event_id = @appointmentId AND request_id = @requestId) 
     BEGIN
          UPDATE adm.MigratedAppointments SET status=@status,retry_count = retry_count+1, LastEditedOn = GETDATE(),ExternalAppointmentId = @externalAppointmentId WHERE event_id = @appointmentId AND request_id = @requestId 
     END
     ELSE
     BEGIN
          INSERT INTO adm.MigratedAppointments (event_id,ExternalAppointmentId,request_id,status,retry_count,CreatedOn) 
          VALUES(@appointmentId,@externalAppointmentId,@requestId,@status,1, GETDATE()) 
     END 
 
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
