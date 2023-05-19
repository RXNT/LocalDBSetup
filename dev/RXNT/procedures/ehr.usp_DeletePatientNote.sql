SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 04-Jul-2016
-- Description:	To Delete Patient Note
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_DeletePatientNote]
	@NoteId BIGINT,
	@PatientId BIGINT
AS
BEGIN
 UPDATE PATIENT_NOTES  
 SET void = 1
 WHERE note_id = @NoteId AND PA_ID = @PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
