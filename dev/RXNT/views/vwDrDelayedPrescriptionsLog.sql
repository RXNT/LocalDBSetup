SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   VIEW [dbo].[vwDrDelayedPrescriptionsLog]
AS
SELECT     dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
                      dbo.patients.pa_phone, dbo.patients.pa_dob, dbo.prescriptions.pres_id, dbo.prescriptions.dg_id, dbo.prescriptions.pres_entry_date, 
                      dbo.prescriptions.pres_read_date, dbo.prescriptions.off_dr_list, dbo.prescriptions.only_faxed, dbo.prescriptions.pharm_id, 
                      dbo.prescriptions.prim_dr_id, dbo.prescriptions.fax_conf_send_date, dbo.prescriptions.fax_conf_numb_pages, 
                      dbo.prescriptions.fax_conf_remote_fax_id, dbo.prescriptions.fax_conf_error_string, dbo.prescriptions.pres_delivery_method, 
                      dbo.doctors.time_difference, dbo.prescriptions.pres_approved_date, dbo.prescriptions.dr_id, dbo.prescriptions.pres_void, 
                      dbo.prescriptions.pres_void_comments, dbo.prescription_details.drug_name, dbo.prescription_details.pd_id, dbo.prescription_details.dosage, 
                      dbo.prescription_details.duration_amount, dbo.prescription_details.comments, dbo.prescription_details.compound,dbo.prescription_details.duration_unit, dbo.prescription_details.prn, dbo.prescription_details.days_supply,
                      dbo.prescription_details.prn_description, dbo.prescription_details.numb_refills, dbo.prescription_details.use_generic, 
                      dbo.prescriptions.pres_prescription_type, dbo.pharmacies.pharm_company_name, dbo.pharmacies.pharm_address1, 
                      dbo.pharmacies.pharm_address2, dbo.pharmacies.pharm_city, dbo.pharmacies.pharm_state, dbo.pharmacies.pharm_zip, 
                      dbo.pharmacies.pharm_phone, CASE WHEN dbo.prescriptions.DoPrintAfterPatHistory = 0 AND dbo.prescriptions.DoPrintAfterPatOrig = 0 AND 
                      dbo.prescriptions.DoPrintAfterPatCopy = 0 AND dbo.prescriptions.DoPrintAfterPatMonograph = 0 THEN 0 ELSE 1 END printOptionsSet, 
                      dbo.scheduled_events.next_fire_date, dbo.scheduled_events.se_id,
dbo.scheduled_events.for_user_id, dbo.scheduled_events.entry_user_id 
FROM         dbo.prescriptions INNER JOIN
                      dbo.patients ON dbo.prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
                      dbo.doctors ON dbo.prescriptions.dr_id = dbo.doctors.dr_id INNER JOIN
                      dbo.prescription_details ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id LEFT OUTER JOIN
                      dbo.pharmacies ON dbo.prescriptions.pharm_id = dbo.pharmacies.pharm_id INNER JOIN
                      dbo.scheduled_events ON dbo.prescription_details.pd_id = dbo.scheduled_events.pd_id
WHERE     (dbo.prescriptions.pres_approved_date IS NULL) AND (dbo.prescriptions.pres_void = 1) AND (dbo.scheduled_events.event_type = 65536) AND 
                      (dbo.scheduled_events.next_fire_date > getDate())
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
