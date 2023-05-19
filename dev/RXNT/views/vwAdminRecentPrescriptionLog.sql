SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwAdminRecentPrescriptionLog]
AS
SELECT dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.doctors.dr_state,dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
  prescriptions.pres_id, prescriptions.pres_entry_date, response_type, response_date, prescriptions.dr_id, 
  prescriptions.pharm_id, delivery_method, prescriptions.pres_approved_date, prescriptions.pres_void, 
  pharmacies.pharm_company_name, pharmacies.pharm_phone, prescription_status.queued_date,
  CASE WHEN pharmacies.pharm_id IS NULL THEN 'Print-Only' ELSE pharm_fax END pharm_fax, 
  response_text, admin_notes, prescriptions.pres_delivery_method, prescription_details.pd_id, drug_name, dosage,
  duration_amount, duration_unit, numb_refills, comments, use_generic
FROM dbo.prescriptions INNER JOIN dbo.prescription_details ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id
  INNER JOIN prescription_status ON prescription_details.pd_id = prescription_status.pd_id INNER JOIN
  dbo.patients ON prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
  dbo.doctors ON prescriptions.dr_id = dbo.doctors.dr_id LEFT OUTER JOIN
  pharmacies ON pharmacies.pharm_id = prescriptions.pharm_id
WHERE pres_approved_date IS NOT NULL AND pres_void = 0 AND 
prescriptions.pres_approved_date > getdate() - 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
