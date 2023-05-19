SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_UpdatePatientCompletedMessage]
(
	@PatientId	BIGINT,
	@MessageId BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;

	update dbo.doctor_patient_messages 
	set [is_complete] = 1 
	WHERE id = @MessageId AND [to_id] = @PatientId 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
