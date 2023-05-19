SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE    VIEW [dbo].[vwDrPrescriptionLogV2]
AS

SELECT TOP 100 PERCENT doctors.dr_last_name, doctors.dr_first_name, patients.pa_id, patients.pa_first, patients.pa_middle, 
patients.pa_last, prescriptions.pres_id, prescriptions.dr_id, prescriptions.prim_dr_id, prescriptions.pres_approved_date, 
doctors.dg_id, prescription_details.drug_name, prescription_details.dosage, prescription_details.pd_id, 
prescriptions.admin_notes, prescription_status.delivery_method, prescription_status.response_type, 
prescription_status.response_text, prescription_status.response_date, prescription_status.confirmation_id 
FROM prescriptions 
INNER JOIN patients ON prescriptions.pa_id = patients.pa_id 
INNER JOIN doctors ON prescriptions.dr_id = doctors.dr_id 
INNER JOIN prescription_details ON prescriptions.pres_id = prescription_details.pres_id 
LEFT OUTER JOIN prescription_status ON prescription_details.pd_id = prescription_status.pd_id 
WHERE (NOT (prescriptions.pres_approved_date IS NULL)) 
AND (prescriptions.pres_void = 0) 
ORDER BY prescriptions.pres_approved_date DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
