SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[GetFailedWorkList] 
	 @DoctorId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 75 
	send_date,
				spe_mess.[spo_ir_id], 
				spe_mess.pd_id, 
				 spe_mess.response_message,
				 spe_mess.message_type,
				doctors.dr_last_name, 
              doctors.dr_first_name, 
              doctors.time_difference, 
			  PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,
              patients.pa_id, 
              patients.pa_first, 
              patients.pa_middle, 
              patients.pa_last,              
              patients.pa_dob,              
              patients.pa_id,              
              prescriptions.pres_id, 
              prescriptions.dr_id, 
              prescriptions.prim_dr_id, 
              prescriptions.pres_approved_date, 
              prescriptions.pres_entry_date, 
              ph.pharm_id, 
              ph.pharm_company_name, 
              ph.pharm_address1, 
              ph.pharm_address2, 
              ph.pharm_city, 
              ph.pharm_state, 
              ph.pharm_zip, 
              ph.pharm_phone, 
              ph.pharm_fax
FROM   [spe].[SPEMessages] spe_mess WITH(nolock) 
       INNER JOIN prescriptions 
               ON prescriptions.pres_id = spe_mess.pres_id
       INNER JOIN patients 
               ON prescriptions.pa_id = patients.pa_id  
       INNER JOIN doctors WITH(nolock) 
               ON prescriptions.dr_id = doctors.dr_id 
       INNER JOIN prescription_details WITH(nolock) 
               ON prescriptions.pres_id = prescription_details.pres_id 
 LEFT OUTER JOIN DOCTORS 
				PRIM_DOCS WITH(NOLOCK) ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID 
       LEFT OUTER JOIN pharmacies PH WITH(nolock) 
                    ON prescriptions.pharm_id = ph.pharm_id 
WHERE  prescriptions.dr_id = @DoctorId AND spe_mess.is_success =0 ORDER BY send_date DESC
	
		   
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
