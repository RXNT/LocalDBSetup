SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 01-Jul-2016
-- Description:	To Search Patient Notes
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchPatientNotes]
	@PatientId BIGINT,
	@DoctorId BIGINT
AS
BEGIN
	DECLARE @Offset INT;
	SELECT TOP 1 @Offset=time_difference from doctors where dr_id = @DoctorId
	SELECT 
		note_id,
		dr_id,
		dateadd(hh,-@offset, note_date) note_date,
		pa_id,note_text,dr_first_name,dr_middle_initial,dr_last_name,dr_prefix,dr_suffix,note_html
	FROM vwPatientNotes WITH(NOLOCK)
	WHERE pa_id = @PatientId 
	ORDER BY note_date DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
