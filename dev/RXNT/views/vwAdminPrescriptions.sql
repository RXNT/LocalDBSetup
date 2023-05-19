SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwAdminPrescriptions]
AS
SELECT presJoin.pres_id, presJoin.pd_id, presJoin.vps_pres_id, presJoin.dr_id, 
  presJoin.pharm_id, presJoin.pa_id, presJoin.pres_entry_date, 
  presJoin.pres_read_date, dbo.pharmacies.pharm_company_name, dbo.pharmacies.pharm_fax, dbo.doctors.dr_first_name, 
  dbo.doctors.dr_middle_initial, dbo.doctors.dr_last_name, dbo.doctors.dr_prefix, dbo.doctors.dr_suffix, dbo.patients.pa_first, dbo.patients.pa_middle, 
  dbo.patients.pa_last, presJoin.pres_delivery_method, presJoin.fax_conf_error_string, presJoin.fill_date, presJoin.pres_approved_date, presJoin.pres_void, 
  presJoin.fax_conf_send_date, dbo.doctors.dr_state, numScripts, numDelivered, numFilled
FROM  (SELECT  dbo.prescriptions.pres_id, dbo.prescription_details.pd_id, dbo.prescription_details.vps_pres_id, dbo.prescriptions.dr_id, 
  dbo.prescriptions.pharm_id, dbo.prescriptions.pa_id, dbo.prescriptions.pres_entry_date, dbo.prescriptions.pres_approved_date, dbo.prescriptions.pres_void,
  MAX(dbo.prescriptions.pres_read_date) pres_read_date, dbo.prescriptions.pres_delivery_method, MAX(dbo.prescriptions.fax_conf_error_string) fax_conf_error_string, 
  MAX(dbo.prescription_details.fill_date) fill_date, MAX(dbo.prescriptions.fax_conf_send_date) fax_conf_send_date, 
  COUNT(CASE WHEN include_in_pharm_deliver <> 0 THEN dbo.prescription_details.pd_id END) numScripts, 
  COUNT(CASE WHEN include_in_pharm_deliver <> 0 THEN dbo.prescription_details.pres_read_date END) numDelivered,
  COUNT(CASE WHEN include_in_pharm_deliver <> 0 THEN dbo.prescription_details.fill_date END) numFilled  
  FROM dbo.prescriptions INNER JOIN dbo.prescription_details ON prescriptions.pres_id = prescription_details.pres_id
  WHERE dbo.prescriptions.sfi_is_sfi = 0
  GROUP BY dbo.prescriptions.pres_id, dbo.prescription_details.pd_id, dbo.prescription_details.vps_pres_id, dbo.prescriptions.dr_id, 
  dbo.prescriptions.pharm_id, dbo.prescriptions.pa_id, dbo.prescriptions.pres_entry_date, dbo.prescriptions.pres_delivery_method, 
  dbo.prescriptions.pres_approved_date, dbo.prescriptions.pres_void) presJoin 
  INNER JOIN dbo.doctors ON presJoin.dr_id = dbo.doctors.dr_id INNER JOIN 
  dbo.patients ON presJoin.pa_id = dbo.patients.pa_id LEFT OUTER JOIN
  dbo.pharmacies ON presJoin.pharm_id = dbo.pharmacies.pharm_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
