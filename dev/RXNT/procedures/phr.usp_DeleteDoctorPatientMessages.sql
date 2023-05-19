SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_DeleteDoctorPatientMessages]
	
	@PatientId	BIGINT,
	@MessageId BIGINT,
	@SelectionType VARCHAR(6)
AS
BEGIN

	IF @SelectionType='INBOX'
	  BEGIN 
		update doctor_patient_messages set to_deleted_id = @PatientId WHERE id = @MessageId
	  END
	ELSE
	  BEGIN
		update doctor_patient_messages set from_deleted_id = @PatientId WHERE id = @MessageId
	  END  

	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
