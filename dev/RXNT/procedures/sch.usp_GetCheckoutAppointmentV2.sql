SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod 
-- Create date: 6/4/2019
-- Description:	Checkout the appointment V2

-- =============================================
CREATE PROCEDURE [sch].[usp_GetCheckoutAppointmentV2] 
	-- Add the parameters for the stored procedure here
	@PatientId BIGINT,
    @AppointmentId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	
	SELECT pv.chkout_notes, sm.dtCheckedOut, pv.clinical_notes,E.encounter_version
	FROM patient_visit pv 
	INNER JOIN scheduler_main sm ON pv.appt_id = sm.event_id
	INNER JOIN [patient_visit_appointment_detail] pvad ON pv.visit_id = pvad.visit_id
	LEFT OUTER JOIN enchanced_encounter E ON pv.enc_id = E.enc_id
	WHERE pv.pa_id = @PatientId
				AND pvad.AppointmentId = @AppointmentId
	
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
