SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW vwAdminPrescriptionLog
AS
SELECT dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
  presJoin.pres_id, presJoin.pres_entry_date, presJoin.pres_read_date, presJoin.dr_id, presJoin.off_dr_list, presJoin.only_faxed, 
  presJoin.pharm_id, presJoin.fax_conf_send_date, presJoin.fax_conf_numb_pages, 
  presJoin.fax_conf_remote_fax_id, presJoin.fax_conf_error_string, presJoin.fill_date, presJoin.pres_delivery_method, presJoin.pres_approved_date, presJoin.pres_void, 
  CASE WHEN pharmacies.pharm_id IS NULL THEN 'Print-Only' ELSE pharm_fax END pharm_fax, CASE WHEN presJoin.admin_notes IS NULL 
  THEN '' ELSE presJoin.admin_notes END admin_notes, numScripts, numDelivered, numFilled
FROM   (SELECT dbo.prescriptions.pres_id, dbo.prescriptions.pres_entry_date, 
    	MAX(dbo.prescription_details.pres_read_date) pres_read_date, dbo.prescriptions.off_dr_list, 
    	dbo.prescriptions.only_faxed, dbo.prescriptions.pharm_id, MAX(dbo.prescription_details.fax_conf_send_date) fax_conf_send_date, 
    	SUM(dbo.prescription_details.fax_conf_numb_pages) fax_conf_numb_pages, MAX(dbo.prescription_details.fax_conf_remote_fax_id) fax_conf_remote_fax_id, 
    	MAX(dbo.prescription_details.fax_conf_error_string) fax_conf_error_string, MAX(dbo.prescription_details.fill_date) fill_date, dbo.prescriptions.admin_notes, 
    	dbo.prescriptions.pres_delivery_method, dbo.prescriptions.pres_approved_date, dbo.prescriptions.pres_void, 
    	dbo.prescriptions.dr_id, dbo.prescriptions.pa_id, 
        COUNT(CASE WHEN include_in_pharm_deliver <> 0 THEN dbo.prescription_details.pd_id END) numScripts, 
	COUNT(CASE WHEN include_in_pharm_deliver <> 0 THEN dbo.prescription_details.pres_read_date END) numDelivered,
        COUNT(CASE WHEN include_in_pharm_deliver <> 0 THEN dbo.prescription_details.fill_date END) numFilled  
  	FROM         dbo.prescriptions INNER JOIN dbo.prescription_details ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id
        WHERE dbo.prescriptions.sfi_is_sfi = 0
    	GROUP BY dbo.prescriptions.pres_id, dbo.prescriptions.pres_entry_date, dbo.prescriptions.off_dr_list, 
    	  dbo.prescriptions.only_faxed, dbo.prescriptions.pharm_id, dbo.prescriptions.admin_notes, 
    	  dbo.prescriptions.pres_delivery_method, dbo.prescriptions.pres_approved_date, dbo.prescriptions.pres_void, 
    	  dbo.prescriptions.dr_id, dbo.prescriptions.pa_id) presJoin INNER JOIN
   dbo.patients ON presJoin.pa_id = dbo.patients.pa_id INNER JOIN
   dbo.doctors ON presJoin.dr_id = dbo.doctors.dr_id LEFT OUTER JOIN
   pharmacies ON pharmacies.pharm_id = presJoin.pharm_id
WHERE  EXISTS (SELECT  pres_id FROM  prescription_details WHERE pres_id = presJoin.pres_id) AND pres_approved_date IS NOT NULL AND pres_void = 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
