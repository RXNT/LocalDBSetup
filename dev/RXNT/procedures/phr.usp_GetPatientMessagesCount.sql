SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_GetPatientMessagesCount] --38835763
	@PatientId bigint
AS
BEGIN
	SET NOCOUNT ON;
	Declare @Count as int
	
		    
		SELECT @Count=COUNT(1)
		FROM [dbo].[doctor_patient_messages] 
		LEFT OUTER JOIN DOCTORS dFrom ON dFrom.dr_id = from_id 
		LEFT OUTER JOIN PATIENTS pFrom ON pFrom.pa_id = from_id 
		WHERE [to_deleted_id] IS NULL and [to_id] = @PatientId
		AND ISNULL(is_read,0) = 0
		AND MSG_DATE > DATEADD(M, -1, GETDATE()) 
	Select @Count as MessageCount
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
