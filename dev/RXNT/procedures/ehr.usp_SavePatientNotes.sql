SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 01-Jul-2016
-- Description:	To Save Patient Note
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SavePatientNotes]
	@NoteId BIGINT OUTPUT,
	@PatientId BIGINT,
	@DoctorId BIGINT,
	@NoteText VARCHAR(2000),
	@NoteHtml VARCHAR(MAX)
	
AS
BEGIN
	IF ISNULL(@NoteId ,0 ) = 0
	BEGIN
		 INSERT INTO PATIENT_NOTES (PA_ID, DR_ID, NOTE_TEXT, NOTE_HTML)
		 VALUES (@PatientId, @DoctorId, @NoteText, @NoteHtml);
		 SET @NoteId = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE PATIENT_NOTES 
		SET NOTE_HTML = @NoteHtml,
			NOTE_TEXT = @NoteText
		WHERE note_id = @NoteId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
