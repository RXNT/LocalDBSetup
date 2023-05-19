SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 2008/1/15
-- Description:	Fetch pending scripts
-- =============================================
CREATE PROCEDURE [dbo].[FetchPendingScripts]
	@daysBack int,@drState varchar(2) = ''
AS
BEGIN
	
	SET NOCOUNT ON;
 IF @drState <> '' 
   BEGIN
  SELECT dbo.doctors.dr_last_name, dbo.doctors.dr_first_name,
	dbo.doctors.dr_create_date,
 dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
    prescriptions.pres_id, prescriptions.dg_id, prescriptions.pres_entry_date, response_date, response_type, prescriptions.pharm_id, prescriptions.prim_dr_id, 
    confirmation_id, response_text, admin_notes, prescriptions.pres_delivery_method, delivery_method, prescriptions.pres_approved_date, prescriptions.pres_void, prescriptions.dr_id, 
    pharmacies.pharm_company_name, pharmacies.pharm_phone, CASE WHEN pharmacies.pharm_id IS NULL THEN 'Print-Only' ELSE pharm_fax END pharm_fax, 
    prescription_details.pd_id, drug_name, dosage, duration_amount, duration_unit, numb_refills, comments, use_generic, prescription_status.queued_date max_queued_date, dbo.prescriptions.SEND_COUNT
  FROM 	dbo.prescriptions WITH (NOLOCK) INNER JOIN dbo.prescription_details WITH (NOLOCK) ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id    
    INNER JOIN dbo.patients WITH (NOLOCK) ON prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
    dbo.doctors WITH (NOLOCK) ON prescriptions.dr_id = dbo.doctors.dr_id 
	INNER JOIN dbo.prescription_status WITH (NOLOCK) ON dbo.prescription_details.pd_id = dbo.prescription_status.pd_id LEFT OUTER JOIN
    pharmacies WITH (NOLOCK) ON pharmacies.pharm_id = prescriptions.pharm_id
  WHERE dr_state=@drState AND (prescriptions.pres_approved_date IS NOT NULL) AND prescriptions.pres_approved_date > GETDATE()- @daysBack AND (prescriptions.pres_void = 0)   AND delivery_method <> 0x02 
	and (prescription_status.response_type=1 or prescription_status.response_type is null)
ORDER BY prescription_status.queued_date desc, prescriptions.pres_id
END
ELSE
	BEGIN
	  SELECT dbo.doctors.dr_last_name, dbo.doctors.dr_first_name,
		dbo.doctors.dr_create_date,
	 dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
		prescriptions.pres_id, prescriptions.dg_id, prescriptions.pres_entry_date, response_date, response_type, prescriptions.pharm_id, prescriptions.prim_dr_id, 
		confirmation_id, response_text, admin_notes, prescriptions.pres_delivery_method, delivery_method, prescriptions.pres_approved_date, prescriptions.pres_void, prescriptions.dr_id, 
		pharmacies.pharm_company_name, pharmacies.pharm_phone, CASE WHEN pharmacies.pharm_id IS NULL THEN 'Print-Only' ELSE pharm_fax END pharm_fax, 
		prescription_details.pd_id, drug_name, dosage, duration_amount, duration_unit, numb_refills, comments, use_generic, prescription_status.queued_date max_queued_date, dbo.prescriptions.SEND_COUNT
	  FROM 	dbo.prescriptions WITH (NOLOCK) INNER JOIN dbo.prescription_details WITH (NOLOCK) ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id    
		INNER JOIN dbo.patients WITH (NOLOCK) ON prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
		dbo.doctors WITH (NOLOCK) ON prescriptions.dr_id = dbo.doctors.dr_id 
		INNER JOIN dbo.prescription_status WITH (NOLOCK) ON dbo.prescription_details.pd_id = dbo.prescription_status.pd_id LEFT OUTER JOIN
		pharmacies WITH (NOLOCK) ON pharmacies.pharm_id = prescriptions.pharm_id
	  WHERE (prescriptions.pres_approved_date IS NOT NULL) AND prescriptions.pres_approved_date > GETDATE()- @daysBack AND (prescriptions.pres_void = 0) AND delivery_method <> 0x02
		and (prescription_status.response_type=1 or prescription_status.response_type is null)
	ORDER BY prescription_status.queued_date desc, prescriptions.pres_id

	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
