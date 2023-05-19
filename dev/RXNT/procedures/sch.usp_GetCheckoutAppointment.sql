SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 5/14/2015
-- Description:	Checkout the appointment
-- Modified By: Sathyavathi D N
-- Modifief On: Aug-02-2016
-- Reason: SV-681 Check out instructions not displaying in SV2 from new encounter
-- =============================================
CREATE PROCEDURE [sch].[usp_GetCheckoutAppointment]
	-- Add the parameters for the stored procedure here
	@PatientId BIGINT,
    @DoctorCompanyId BIGINT,
    @StartDateTime DATETIME2,
    @EndDateTime DATETIME2,
    @DoctorId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @TimeDifference AS BIGINT
	Set @TimeDifference=0
	
	select @TimeDifference= time_difference  from doctors where dr_id=@DoctorId
	if(@TimeDifference>0)
	Begin
		Set @StartDateTime=DATEADD(hh,@TimeDifference,@StartDateTime)
		Set @EndDateTime=DATEADD(hh,@TimeDifference,@EndDateTime)				
	End
	
	SELECT pv.chkout_notes, sm.dtCheckedOut, pv.clinical_notes
	FROM patient_visit pv 
	INNER JOIN scheduler_main sm ON pv.appt_id = sm.event_id
	WHERE pv.pa_id = @PatientId AND sm.event_start_date	= @StartDateTime AND 
				sm.event_end_date	= @EndDateTime AND 
				sm.dr_id			= @DoctorId	AND
				sm.ext_link_id		= @PatientId
	
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
