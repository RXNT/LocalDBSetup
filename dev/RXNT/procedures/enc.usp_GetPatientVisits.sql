SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 20-Jan-2016
-- Description:	To get the patient visits
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPatientVisits] 
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT visit_id,dtcreate,vital_id,reason--,appt_id, pa_id, dr_id, reason, dtend, enc_id, chkout_notes 
	FROM patient_visit P  WITH(NOLOCK) 
	WHERE pa_id=@PatientId and P.enc_id = 0 and dtcreate > GETDATE()-90 ORDER BY dtcreate DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
