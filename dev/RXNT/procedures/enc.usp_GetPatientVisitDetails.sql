SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 29-Jan-2016
-- Description:	To get the patient visit details
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPatientVisitDetails]
	@PatientId BIGINT,
	@VisitId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT visit_id,dtcreate,vital_id,reason,appt_id, pa_id, dr_id, reason, dtend, enc_id, chkout_notes 
	FROM patient_visit WITH(NOLOCK) 
	WHERE pa_id=@PatientId AND visit_id = @VisitId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
