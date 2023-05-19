SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE      VIEW [dbo].[vwPatientHistory]
AS
SELECT dbo.prescriptions.pres_id, dbo.prescriptions.pres_delivery_method, dbo.prescriptions.pres_approved_date, dbo.prescriptions.pres_entry_date, dbo.prescription_details.pd_id, 
  dbo.prescription_details.ddid, dbo.prescription_details.drug_name, dbo.prescription_details.dosage, dbo.prescription_details.use_generic, 
  dbo.prescription_details.numb_refills, dbo.prescription_details.comments, dbo.prescription_details.duration_amount, 
  dbo.prescription_details.duration_unit, dbo.prescription_details.prn, dbo.prescription_details.prn_description, dbo.prescription_details.as_directed, - 1 AS status, 
  dbo.prescription_details.history_enabled,dbo.prescription_details.compound, D.Description ICD9_DESC, dbo.prescriptions.pa_id, dbo.prescriptions.dg_id, dbo.pharmacies.pharm_company_name, 
  dbo.pharmacies.pharm_address1, dbo.pharmacies.pharm_city, dbo.pharmacies.pharm_state, dbo.pharmacies.pharm_zip,dbo.prescription_details.discharge_dr_id, dbo.prescription_details.discharge_desc,
  dbo.prescription_details.discharge_date, dbo.pharmacies.pharm_phone, dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.doctors.dr_prefix,
  CASE WHEN drug_id IS NULL THEN 0 ELSE 1 END active_med
FROM dbo.prescriptions INNER JOIN
  dbo.prescription_details ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id LEFT OUTER JOIN
  dbo.pharmacies ON dbo.prescriptions.pharm_id = dbo.pharmacies.pharm_id INNER JOIN
  dbo.doctors ON dbo.doctors.dr_id = dbo.prescriptions.dr_id LEFT OUTER JOIN dbo.patient_active_meds ON
  dbo.prescription_details.ddid = dbo.patient_active_meds.drug_id AND dbo.prescriptions.pa_id = 
dbo.patient_active_meds.pa_id AND dbo.prescription_details.compound=dbo.patient_active_meds.compound
LEFT OUTER JOIN vwDiagnosis D ON dbo.prescription_details.icd9 = D.icd9
WHERE (NOT (dbo.prescriptions.pres_approved_date IS NULL)) AND (dbo.prescriptions.pres_void = 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
