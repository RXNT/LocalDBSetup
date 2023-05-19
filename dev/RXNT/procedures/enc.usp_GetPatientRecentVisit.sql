SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 29-Jan-2016
-- Description:	To get the patient recent visit details 
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPatientRecentVisit]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1 visit_id,dtcreate,vital_id,reason,appt_id, pa_id, dr_id, reason, dtend, enc_id, chkout_notes 
	FROM patient_visit WITH(NOLOCK) 
	WHERE pa_id=@PatientId  and dtcreate > GETDATE()-90 
	ORDER BY dtcreate DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
