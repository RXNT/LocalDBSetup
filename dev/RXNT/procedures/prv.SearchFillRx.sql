SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 12-OCT-2017
-- Description:	To Search RxFill
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [prv].[SearchFillRx]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @IsAgent bit=0, @PatientFirstName varchar(50)=NULL, @PatientLastName varchar(50)=NULL
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 75 dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.doctors.dr_phone, dbo.patients.pa_id,   
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
	case when dbo.pharmacies.service_level IS null then 0 Else dbo.pharmacies.service_level END pharm_service_level,  
	case when dbo.doctors.epcs_enabled is null then 0 else dbo.doctors.epcs_enabled end doc_epcs_status,dbo.doctors.NPI,  
	case when erx.RxFillRequests.MessageId is null then '' else erx.RxFillRequests.MessageId end MessageId,
	CASE WHEN erx.RxFillRequests.HasMissMatch IS NULL  THEN 0 ELSE erx.RxFillRequests.HasMissMatch END has_miss_match,
	erx.RxFillRequests.MissMatchReason AS miss_match_reson,
	CASE WHEN erx.RxFillRequestsInfo.Date1Enum=6 THEN erx.RxFillRequestsInfo.Date1 WHEN erx.RxFillRequestsInfo.Date2Enum=6 THEN erx.RxFillRequestsInfo.Date2   
	WHEN erx.RxFillRequestsInfo.Date3Enum=6 THEN erx.RxFillRequestsInfo.Date3 ELSE '1901-01-01' END fill_date,   
	CASE WHEN dbo.prescription_details.refills_prn IS NULL Or dbo.prescription_details.refills_prn=0 THEN -1 ELSE 4 END pharm_refill_type,  
	CASE WHEN dbo.prescription_details.refills_prn IS NULL THEN 0 ELSE dbo.prescription_details.refills_prn END refills_prn,  
	CASE WHEN erx.RxFillRequestsInfo.Date1Enum=6 THEN erx.RxFillRequestsInfo.Date1 WHEN erx.RxFillRequestsInfo.Date2Enum=6 THEN erx.RxFillRequestsInfo.Date2  
	WHEN erx.RxFillRequestsInfo.Date3enum=6 THEN erx.RxFillRequestsInfo.Date3 ELSE '1901-01-01' END dispensed_fill_date,   
	CASE WHEN erx.RxFillRequestsInfo.DRUGNAME IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DRUGNAME END DISPENSED_DRUG_NAME,  
	CASE WHEN erx.RxFillRequestsInfo.QTY1 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.QTY1 END DISPENSED_QUANTITY,  
	CASE WHEN erx.RxFillRequestsInfo.QTY1UNITS IS NULL THEN '' ELSE erx.RxFillRequestsInfo.QTY1UNITS END DISPENSED_QUANTITY_UNITS,  
	CASE WHEN erx.RxFillRequestsInfo.RefillsType IS NULL THEN 0 WHEN erx.RxFillRequestsInfo.RefillsType=4 THEN 1 ELSE 0 END DISPENSED_REFILLS_PRN,  
	CASE WHEN erx.RxFillRequestsInfo.REFILLS IS NULL THEN 0 ELSE erx.RxFillRequestsInfo.REFILLS END DISPENSED_REFILLS,  
	CASE WHEN erx.RxFillRequestsInfo.DOSAGE1 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DOSAGE1 END DISPENSED_DOSAGE1,  
	CASE WHEN erx.RxFillRequestsInfo.DOSAGE2 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DOSAGE2 END DISPENSED_DOSAGE2,  
	CASE WHEN erx.RxFillRequestsInfo.COMMENTS1 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.COMMENTS1 END DISPENSED_COMMENTS1,  
	CASE WHEN erx.RxFillRequestsInfo.COMMENTS2 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.COMMENTS2 END DISPENSED_COMMENTS2,  
	CASE WHEN erx.RxFillRequestsInfo.COMMENTS3 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.COMMENTS3 END DISPENSED_COMMENTS3,  
	CASE WHEN erx.RxFillRequestsInfo.DAYSSUPPLY IS NULL THEN -1 ELSE erx.RxFillRequestsInfo.DAYSSUPPLY END DISPENSED_DAYS_SUPPLY,
	CASE WHEN erx.RxFillRequestsInfo.DocInfoText IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DocInfoText END disp_doc_info_text,
	CASE WHEN erx.RxFillRequestsInfo.DocInfoText IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DocInfoText END mn_doc_info_text,      
	CASE WHEN erx.RxFillRequestsInfo.SubstitutionCode IS NULL THEN 1   
	WHEN (erx.RxFillRequestsInfo.SubstitutionCode = 7 Or erx.RxFillRequestsInfo.SubstitutionCode = 1) THEN 0 ELSE 1 END DISPENSED_USE_GENERIC,  
	CASE WHEN dbo.prescriptions.DoPrintAfterPatHistory = 0 AND dbo.prescriptions.DoPrintAfterPatOrig = 0 AND dbo.prescriptions.DoPrintAfterPatCopy = 0 AND dbo.prescriptions.DoPrintAfterPatMonograph = 0 THEN 0 ELSE 1 END printOptionsSet,  
	CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END DRUGLEVEL,prescription_details.hospice_drug_relatedness_id,hdr.Code,hdr.Description  ,prescription_details.drug_indication,
	PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,erx.RxFillRequests.FillReqId,erx.RxFillRequests.FillStatusType,erx.RxFillRequests.FillStatus,
	dbo.pharmacies.ncpdp_numb AS Pharm_NCPDP, dbo.pharmacies.NPI AS Pharm_NPI
	FROM dbo.prescriptions WITH(READPAST) INNER JOIN dbo.prescription_details WITH(READPAST) ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id   
	INNER JOIN dbo.patients WITH(READPAST)  ON dbo.prescriptions.pa_id = dbo.patients.pa_id   
	INNER JOIN dbo.doctors WITH(READPAST) ON dbo.prescriptions.dr_id = dbo.doctors.dr_id
	LEFT OUTER JOIN Doctors PRIM_DOCS on dbo.prescriptions.prim_dr_id = PRIM_DOCS.DR_ID    
	LEFT OUTER JOIN RMIID1 WITH(NOLOCK) ON dbo.prescription_details.ddid = dbo.RMIID1.MEDID   
	LEFT OUTER JOIN dbo.pharmacies WITH(READPAST) ON dbo.prescriptions.pharm_id = dbo.pharmacies.pharm_id 
	LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON prescription_details.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id		  
	INNER JOIN erx.RxFillRequests WITH(READPAST) ON  erx.RxFillRequests.PresId = dbo.prescriptions.pres_id  
	INNER JOIN erx.RxFillRequestsInfo WITH(READPAST) ON erx.RxFillRequestsInfo.FillReqId = erx.RxFillRequests.FillReqId  
	WHERE (((@IsRestrictToPersonalRx=1) AND ((@IsAgent=1 AND dbo.prescriptions.PRIM_DR_ID = @UserId) OR (@IsAgent<>1 AND dbo.prescriptions.DR_ID = @UserId)))
	OR ((@IsRestrictToPersonalRx<>1) AND (dbo.prescriptions.DG_ID = @DoctorGroupId)))
	AND(@PatientFirstName IS NULL OR dbo.patients.pa_first LIKE @PatientFirstName+'%') AND(@PatientLastName IS NULL OR dbo.patients.pa_last LIKE @PatientLastName+'%')
	
	UNION ALL
	
	SELECT TOP 75 dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.doctors.dr_phone, dbo.patients.pa_id,   
	dbo.patients.pa_first, dbo.patients.pa_middle,dbo.patients.pa_flag, dbo.patients.pa_last, dbo.patients.pa_dob,dbo.patients.pa_sex,
	dbo.patients.pa_phone, dbo.patients.pa_ssn,erx.RxFillRequests.PresId AS pres_id, erx.RxFillRequests.DoctorGroupId AS dg_id,
	CASE WHEN erx.RxFillRequests.Date1Enum=2 THEN erx.RxFillRequests.Date1 WHEN erx.RxFillRequests.Date2Enum=2 THEN erx.RxFillRequests.Date2   
	WHEN erx.RxFillRequests.Date3Enum=2 THEN erx.RxFillRequests.Date3 ELSE '1901-01-01' END AS pres_entry_date,
	NULL AS pres_read_date, 0 AS off_dr_list, 0 AS only_faxed, 0 AS pharm_id,   
	NULL AS agent_info,NULL AS supervisor_info,erx.RxFillRequests.DoctorId AS prim_dr_id, NULL AS fax_conf_send_date, 0 AS fax_conf_numb_pages,  
	0 AS fax_conf_remote_fax_id, NULL AS fax_conf_error_string, erx.RxFillRequests.DeliveryMethod AS pres_delivery_method,   
	dbo.doctors.time_difference, erx.RxFillRequests.Date2 AS pres_approved_date, erx.RxFillRequests.DoctorId AS dr_id, 0 AS pres_void,   
	NULL AS pres_void_comments, 0 AS ddid, erx.RxFillRequests.DrugName AS drug_name,   
	0 AS pd_id, erx.RxFillRequests.Dosage1 AS dosage,
	CASE WHEN erx.RxFillRequests.QTY1 IS NULL THEN '' ELSE erx.RxFillRequests.QTY1 END AS duration_amount,   
	erx.RxFillRequests.Comments1 AS comments,0 AS compound, CASE WHEN erx.RxFillRequests.QTY1UNITS IS NULL THEN '' ELSE erx.RxFillRequests.QTY1UNITS END AS duration_unit,   
	0 AS prn,erx.RxFillRequests.DaysSupply AS days_supply, NULL AS prn_description, erx.RxFillRequests.Refills AS numb_refills,   
	0 AS use_generic, 0 AS pres_prescription_type, dbo.pharmacies.pharm_company_name,   
	dbo.pharmacies.pharm_address1, dbo.pharmacies.pharm_address2, dbo.pharmacies.pharm_city, dbo.pharmacies.pharm_state,   
	dbo.pharmacies.pharm_zip, dbo.pharmacies.pharm_phone, dbo.pharmacies.pharm_fax,
	case when dbo.pharmacies.service_level IS null then 0 Else dbo.pharmacies.service_level END pharm_service_level, 
	case when dbo.doctors.epcs_enabled is null then 0 else dbo.doctors.epcs_enabled end doc_epcs_status,dbo.doctors.NPI,  
	case when erx.RxFillRequests.MessageId is null then '' else erx.RxFillRequests.MessageId end MessageId,
	CASE WHEN erx.RxFillRequests.HasMissMatch IS NULL  THEN 0 ELSE erx.RxFillRequests.HasMissMatch END has_miss_match,
	erx.RxFillRequests.MissMatchReason AS miss_match_reson,
	CASE WHEN erx.RxFillRequestsInfo.Date1Enum=6 THEN erx.RxFillRequestsInfo.Date1 WHEN erx.RxFillRequestsInfo.Date2Enum=6 THEN erx.RxFillRequestsInfo.Date2   
	WHEN erx.RxFillRequestsInfo.Date3Enum=6 THEN erx.RxFillRequestsInfo.Date3 ELSE '1901-01-01' END fill_date,   
	-1 AS pharm_refill_type,  
	0 AS refills_prn,  
	CASE WHEN erx.RxFillRequestsInfo.Date1Enum=6 THEN erx.RxFillRequestsInfo.Date1 WHEN erx.RxFillRequestsInfo.Date2Enum=6 THEN erx.RxFillRequestsInfo.Date2  
	WHEN erx.RxFillRequestsInfo.Date3enum=6 THEN erx.RxFillRequestsInfo.Date3 ELSE '1901-01-01' END dispensed_fill_date,   
	CASE WHEN erx.RxFillRequestsInfo.DRUGNAME IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DRUGNAME END DISPENSED_DRUG_NAME,  
	CASE WHEN erx.RxFillRequestsInfo.QTY1 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.QTY1 END DISPENSED_QUANTITY,  
	CASE WHEN erx.RxFillRequestsInfo.QTY1UNITS IS NULL THEN '' ELSE erx.RxFillRequestsInfo.QTY1UNITS END DISPENSED_QUANTITY_UNITS,  
	CASE WHEN erx.RxFillRequestsInfo.RefillsType IS NULL THEN 0 WHEN erx.RxFillRequestsInfo.RefillsType=4 THEN 1 ELSE 0 END DISPENSED_REFILLS_PRN,  
	CASE WHEN erx.RxFillRequestsInfo.REFILLS IS NULL THEN 0 ELSE erx.RxFillRequestsInfo.REFILLS END DISPENSED_REFILLS,  
	CASE WHEN erx.RxFillRequestsInfo.DOSAGE1 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DOSAGE1 END DISPENSED_DOSAGE1,  
	CASE WHEN erx.RxFillRequestsInfo.DOSAGE2 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DOSAGE2 END DISPENSED_DOSAGE2,  
	CASE WHEN erx.RxFillRequestsInfo.COMMENTS1 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.COMMENTS1 END DISPENSED_COMMENTS1,  
	CASE WHEN erx.RxFillRequestsInfo.COMMENTS2 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.COMMENTS2 END DISPENSED_COMMENTS2,  
	CASE WHEN erx.RxFillRequestsInfo.COMMENTS3 IS NULL THEN '' ELSE erx.RxFillRequestsInfo.COMMENTS3 END DISPENSED_COMMENTS3,  
	CASE WHEN erx.RxFillRequestsInfo.DAYSSUPPLY IS NULL THEN -1 ELSE erx.RxFillRequestsInfo.DAYSSUPPLY END DISPENSED_DAYS_SUPPLY,
	CASE WHEN erx.RxFillRequestsInfo.DocInfoText IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DocInfoText END disp_doc_info_text,
	CASE WHEN erx.RxFillRequestsInfo.DocInfoText IS NULL THEN '' ELSE erx.RxFillRequestsInfo.DocInfoText END mn_doc_info_text,      
	CASE WHEN erx.RxFillRequestsInfo.SubstitutionCode IS NULL THEN 1   
	WHEN (erx.RxFillRequestsInfo.SubstitutionCode = 7 Or erx.RxFillRequestsInfo.SubstitutionCode = 1) THEN 0 ELSE 1 END DISPENSED_USE_GENERIC,  
	0 AS printOptionsSet,  
	0 AS DRUGLEVEL,0 AS hospice_drug_relatedness_id,0 AS Code,NULL AS Description  ,NULL AS drug_indication,
	PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,erx.RxFillRequests.FillReqId,erx.RxFillRequests.FillStatusType,erx.RxFillRequests.FillStatus,
	dbo.pharmacies.ncpdp_numb AS Pharm_NCPDP, dbo.pharmacies.NPI AS Pharm_NPI
	FROM erx.RxFillRequests WITH(READPAST)
	INNER JOIN erx.RxFillRequestsInfo WITH(READPAST) ON erx.RxFillRequestsInfo.FillReqId = erx.RxFillRequests.FillReqId
	INNER JOIN dbo.patients WITH(READPAST)  ON erx.RxFillRequests.PatientId = dbo.patients.pa_id   
	INNER JOIN dbo.doctors WITH(READPAST) ON erx.RxFillRequests.DoctorId = dbo.doctors.dr_id 
	LEFT OUTER JOIN Doctors PRIM_DOCS on erx.RxFillRequests.DoctorId = PRIM_DOCS.DR_ID
	LEFT OUTER JOIN dbo.pharmacies WITH(READPAST) ON erx.RxFillRequestsInfo.PharmId = dbo.pharmacies.pharm_id 
	WHERE (((@IsRestrictToPersonalRx=1) AND (erx.RxFillRequests.DoctorId = @UserId))
	OR ((@IsRestrictToPersonalRx<>1) AND (erx.RxFillRequests.DoctorGroupId = @DoctorGroupId)))
	AND(@PatientFirstName IS NULL OR dbo.patients.pa_first LIKE @PatientFirstName+'%') AND(@PatientLastName IS NULL OR dbo.patients.pa_last LIKE @PatientLastName+'%')
	AND erx.RxFillRequests.PresId <=0
	ORDER BY erx.RxFillRequests.FillReqId desc
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
