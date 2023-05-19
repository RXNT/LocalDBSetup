SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/****** Object:  View [dbo].[vwDrPendingPrescriptionLog]    Script Date: 11/16/2017 11:04:19 AM ******/



CREATE VIEW [dbo].[vwDrPendingPrescriptionLog] AS  
SELECT dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.doctors.dr_phone, dbo.patients.pa_id,   
dbo.patients.pa_first, dbo.patients.pa_middle,dbo.patients.pa_flag, dbo.patients.pa_last, dbo.patients.pa_dob,dbo.patients.pa_sex,
dbo.patients.pa_phone, dbo.patients.pa_ssn,dbo.prescriptions.pres_id, dbo.prescriptions.dg_id, dbo.prescriptions.pres_entry_date,  
dbo.prescriptions.pres_read_date, dbo.prescriptions.off_dr_list, dbo.prescriptions.only_faxed, dbo.prescriptions.pharm_id,   
dbo.prescription_details.agent_info,dbo.prescription_details.supervisor_info,dbo.prescriptions.prim_dr_id, dbo.prescriptions.fax_conf_send_date, dbo.prescriptions.fax_conf_numb_pages,  
dbo.prescriptions.fax_conf_remote_fax_id, dbo.prescriptions.fax_conf_error_string, dbo.prescriptions.pres_delivery_method,   
dbo.doctors.time_difference, dbo.prescriptions.pres_approved_date, dbo.prescriptions.dr_id, dbo.prescriptions.pres_void,   
dbo.prescriptions.pres_void_comments, dbo.prescription_details.ddid, dbo.prescription_details.drug_name,   
dbo.prescription_details.pd_id, dbo.prescription_details.dosage, dbo.prescription_details.duration_amount,   
dbo.prescription_details.comments,dbo.prescription_details.compound, dbo.prescription_details.duration_unit,   
dbo.prescription_details.prn,dbo.prescription_details.days_supply, dbo.prescription_details.prn_description, dbo.prescription_details.numb_refills,   
dbo.prescription_details.use_generic, dbo.prescriptions.pres_prescription_type, dbo.pharmacies.pharm_company_name,   
dbo.pharmacies.pharm_address1, dbo.pharmacies.pharm_address2, dbo.pharmacies.pharm_city, dbo.pharmacies.pharm_state,   
dbo.pharmacies.pharm_zip, dbo.pharmacies.pharm_phone, dbo.pharmacies.pharm_fax,
PE.pa_nick_name,
case when dbo.pharmacies.service_level IS null then 0 Else dbo.pharmacies.service_level END pharm_service_level,  
case when dbo.doctors.epcs_enabled is null then 0 else dbo.doctors.epcs_enabled end doc_epcs_status,dbo.doctors.NPI,  
case when dbo.refill_requests.ctrl_number is null then '' else dbo.refill_requests.ctrl_number end ctrl_number, 
CASE WHEN dbo.refill_requests.has_miss_match IS NULL  THEN 0 ELSE dbo.refill_requests.has_miss_match END has_miss_match,
dbo.refill_requests.miss_match_reson, 
CASE WHEN dbo.refill_requests.date1_enum=6 THEN dbo.refill_requests.date1 WHEN dbo.refill_requests.date2_enum=6 THEN dbo.refill_requests.date2   
WHEN dbo.refill_requests.date3_enum=6 THEN dbo.refill_requests.date3 ELSE '1901-01-01' END fill_date,   
CASE WHEN dbo.prescription_details.refills_prn IS NULL Or dbo.prescription_details.refills_prn=0 THEN -1 ELSE 4 END pharm_refill_type,  
CASE WHEN dbo.prescription_details.refills_prn IS NULL THEN 0 ELSE dbo.prescription_details.refills_prn END refills_prn,  
CASE WHEN dbo.refill_requests_info.date1_enum=6 THEN dbo.refill_requests_info.date1 WHEN dbo.refill_requests_info.date2_enum=6 THEN dbo.refill_requests_info.date2  
WHEN dbo.refill_requests_info.date3_enum=6 THEN dbo.refill_requests_info.date3 ELSE '1901-01-01' END dispensed_fill_date,   
CASE WHEN dbo.refill_requests_info.DRUG_NAME IS NULL THEN '' ELSE dbo.refill_requests_info.DRUG_NAME END DISPENSED_DRUG_NAME,  
CASE WHEN dbo.refill_requests_info.QTY1 IS NULL THEN '' ELSE dbo.refill_requests_info.QTY1 END DISPENSED_QUANTITY,  
CASE WHEN dbo.refill_requests_info.QTY1_UNITS IS NULL THEN '' ELSE dbo.refill_requests_info.QTY1_UNITS END DISPENSED_QUANTITY_UNITS,  
CASE WHEN dbo.refill_requests_info.refills_enum IS NULL THEN 0 WHEN dbo.refill_requests_info.refills_enum=4 THEN 1 ELSE 0 END DISPENSED_REFILLS_PRN,  
CASE WHEN dbo.refill_requests_info.REFILLS IS NULL THEN 0 ELSE dbo.refill_requests_info.REFILLS END DISPENSED_REFILLS,  
CASE WHEN dbo.refill_requests_info.DOSAGE1 IS NULL THEN '' ELSE dbo.refill_requests_info.DOSAGE1 END DISPENSED_DOSAGE1,  
CASE WHEN dbo.refill_requests_info.DOSAGE2 IS NULL THEN '' ELSE dbo.refill_requests_info.DOSAGE2 END DISPENSED_DOSAGE2,  
CASE WHEN dbo.refill_requests_info.COMMENTS1 IS NULL THEN '' ELSE dbo.refill_requests_info.COMMENTS1 END DISPENSED_COMMENTS1,  
CASE WHEN dbo.refill_requests_info.COMMENTS2 IS NULL THEN '' ELSE dbo.refill_requests_info.COMMENTS2 END DISPENSED_COMMENTS2,  
CASE WHEN dbo.refill_requests_info.COMMENTS3 IS NULL THEN '' ELSE dbo.refill_requests_info.COMMENTS3 END DISPENSED_COMMENTS3,  
CASE WHEN dbo.refill_requests_info.DAYS_SUPPLY IS NULL THEN -1 ELSE dbo.refill_requests_info.DAYS_SUPPLY END DISPENSED_DAYS_SUPPLY,
CASE WHEN dbo.refill_requests_info.doc_info_text IS NULL THEN '' ELSE dbo.refill_requests_info.doc_info_text END disp_doc_info_text,
CASE WHEN dbo.refill_requests.doc_info_text IS NULL THEN '' ELSE dbo.refill_requests.doc_info_text END mn_doc_info_text,      
CASE WHEN dbo.refill_requests_info.substitution_code IS NULL THEN 1   
WHEN (dbo.refill_requests_info.substitution_code = 7 Or dbo.refill_requests_info.substitution_code = 1) THEN 0 ELSE 1 END DISPENSED_USE_GENERIC,  
CASE WHEN dbo.prescriptions.DoPrintAfterPatHistory = 0 AND dbo.prescriptions.DoPrintAfterPatOrig = 0 AND dbo.prescriptions.DoPrintAfterPatCopy = 0 AND dbo.prescriptions.DoPrintAfterPatMonograph = 0 THEN 0 ELSE 1 END printOptionsSet,  
CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END DRUGLEVEL,prescription_details.hospice_drug_relatedness_id,hdr.Code,hdr.Description  ,
prescription_details.drug_indication,
dbo.pharmacies.ncpdp_numb AS Pharm_NCPDP, dbo.pharmacies.NPI AS Pharm_NPI
,dbo.prescription_details.hide_on_pending_rx
FROM dbo.prescriptions WITH(NOLOCK) INNER JOIN dbo.prescription_details WITH(NOLOCK) ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id   
INNER JOIN dbo.patients WITH(NOLOCK)  ON dbo.prescriptions.pa_id = dbo.patients.pa_id   
LEFT OUTER JOIN [patient_extended_details] PE WITH(NOLOCK) ON PE.pa_id = patients.pa_id 
INNER JOIN dbo.doctors WITH(NOLOCK) ON dbo.prescriptions.dr_id = dbo.doctors.dr_id   
LEFT OUTER JOIN RMIID1 WITH(NOLOCK) ON dbo.prescription_details.ddid = dbo.RMIID1.MEDID   
LEFT OUTER JOIN dbo.pharmacies WITH(NOLOCK) ON dbo.prescriptions.pharm_id = dbo.pharmacies.pharm_id 
LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON prescription_details.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id		  
LEFT OUTER JOIN dbo.refill_requests WITH(NOLOCK) ON  dbo.refill_requests.pres_id = dbo.prescriptions.pres_id  
LEFT OUTER JOIN dbo.refill_requests_info WITH(NOLOCK) ON dbo.refill_requests_info.refreq_id = dbo.refill_requests.refreq_id  
WHERE (dbo.prescriptions.pres_approved_date IS NULL) AND (dbo.prescriptions.pres_void = 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
