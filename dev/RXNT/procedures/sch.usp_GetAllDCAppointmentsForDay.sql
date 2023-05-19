SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Sathyavathi D N
Create date			:	28-Nov-2017
Description			:	This procedure is used to fetch all doctor appointments for day
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [sch].[usp_GetAllDCAppointmentsForDay]	
    @DoctorCompanyId BIGINT,
    @StartDateTime DATETIME2,
    @EndDateTime DATETIME2    
AS
BEGIN			
	SELECT ENC.enc_id,
		   ENC.is_released,
		   ENC.issigned,
		   ENC.enc_id external_encounter_id ,		   
		   SM.event_start_date,
		   SM.event_end_date,
		   DATEADD(hh,-DR.time_difference,SM.event_start_date) AS 'StartTimeFromSCH',
		   DATEADD(hh,-DR.time_difference,SM.event_end_date) AS 'EndTimeFromSCH',		   
		   SM.ext_link_id FROM dbo.scheduler_main SM WITH(NOLOCK) 
	INNER JOIN dbo.patient_visit PV WITH(NOLOCK) ON PV.pa_id = SM.ext_link_id 
													AND SM.dr_id = PV.dr_id
													AND SM.event_id = PV.appt_id
	INNER JOIN dbo.doctors DR WITH(NOLOCK) ON SM.dr_id = DR.dr_id 
	INNER JOIN dbo.doc_groups DG WITH(NOLOCK) ON DR.dg_id = DG.dg_id
	LEFT JOIN enchanced_encounter ENC on ENC.enc_id = PV.enc_id
	WHERE dg.dc_id = @DoctorCompanyId AND		  
		 (SM.event_start_date >= @StartDateTime AND SM.event_start_date <= @EndDateTime)		
		 AND ENC.enc_id IS NOT NULL
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
