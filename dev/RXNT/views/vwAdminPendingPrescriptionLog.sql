SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE    VIEW [dbo].[vwAdminPendingPrescriptionLog]
AS
-- Top 12000, approved, delivery_method not online, response_date is null
  SELECT     dbo.doctors.dr_last_name, dbo.doctors.dr_first_name,
	dbo.doctors.dr_create_date,
 dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
    prescriptions.pres_id, prescriptions.dg_id, prescriptions.pres_entry_date, response_date, response_type, prescriptions.pharm_id, prescriptions.prim_dr_id, 
    confirmation_id, response_text, admin_notes, prescriptions.pres_delivery_method, delivery_method, prescriptions.pres_approved_date, prescriptions.pres_void, prescriptions.dr_id, 
    pharmacies.pharm_company_name, pharmacies.pharm_phone, CASE WHEN pharmacies.pharm_id IS NULL THEN 'Print-Only' ELSE pharm_fax END pharm_fax, 
    prescription_details.pd_id, drug_name, dosage, duration_amount, duration_unit, numb_refills, comments, use_generic, prescription_status.queued_date, Max(dbo.prescriptions.SEND_COUNT) send_count,
    MAX(prescription_status.queued_date) max_queued_date
  FROM 	dbo.prescriptions INNER JOIN dbo.prescription_details WITH (NOLOCK) ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id
    INNER JOIN prescription_status WITH (NOLOCK) ON prescription_details.pd_id = prescription_status.pd_id
    INNER JOIN dbo.patients WITH (NOLOCK) ON prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
    dbo.doctors WITH (NOLOCK) ON prescriptions.dr_id = dbo.doctors.dr_id LEFT OUTER JOIN
    pharmacies WITH (NOLOCK) ON pharmacies.pharm_id = prescriptions.pharm_id
  WHERE (prescriptions.off_dr_list = 0) AND (NOT (prescriptions.pres_approved_date IS NULL)) AND (prescriptions.pres_void = 0)
    AND prescriptions.pres_id > (SELECT MAX(pres_id) - 12000 FROM prescriptions)
    AND EXISTS (select pd_id from prescription_details where response_type <> 0 or response_type is null ) AND delivery_method <> 0x02
  GROUP BY dbo.doctors.dr_last_name, dbo.doctors.dr_first_name,dbo.doctors.dr_create_date, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
    prescriptions.pres_id, prescriptions.dg_id, prescriptions.pres_entry_date, response_date, response_type, prescriptions.pharm_id, prescriptions.prim_dr_id, 
    confirmation_id, response_text, admin_notes, prescriptions.pres_delivery_method, delivery_method, prescriptions.pres_approved_date, prescriptions.pres_void, prescriptions.dr_id, 
    pharmacies.pharm_company_name, pharmacies.pharm_phone, CASE WHEN pharmacies.pharm_id IS NULL THEN 'Print-Only' ELSE pharm_fax END, 
    prescription_details.pd_id, drug_name, dosage, duration_amount, duration_unit, numb_refills, comments, use_generic, prescription_status.queued_date
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
