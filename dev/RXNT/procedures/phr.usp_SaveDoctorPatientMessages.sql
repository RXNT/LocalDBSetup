SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Save Doctor Patient Messages
-- =============================================
CREATE PROCEDURE  [phr].[usp_SaveDoctorPatientMessages]
  @PatientId bigint,
	@ToId      bigint,
	@Message   VARCHAR(MAX),
	@MessageDate DATETIME,
	@MessageDigestion VARCHAR(500),
	@PatientRepresentativeId BIGINT = NULL
	
AS
BEGIN
	INSERT INTO doctor_patient_messages(from_id, to_id, msg_date, message,messagedigest, PatientRepresentativeId) 
     VALUES(@PatientId, @ToId, @MessageDate, @Message,@MessageDigestion, @PatientRepresentativeId)	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
