SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Sheikh
Create date			:	19-April-2021
Description			:	
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[SearchChangeRxForPatient] --[ehr].[SearchChangeRxForPatient]  117936,4,1,0,65639805 
	@UserId BIGINT, 
	@DoctorGroupId BIGINT,
	@IsRestrictToPersonalRx BIT = 1,
	@IsAgent BIT=0,
	@PatientId BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 75 RRR.ChgReqId, RRR.PriorAuthNum, dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.doctors.dr_phone, dbo.patients.pa_id,   
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
	dbo.prescription_details.use_generic, dbo.prescriptions.pres_prescription_type,   
	case when dbo.doctors.epcs_enabled is null then 0 else dbo.doctors.epcs_enabled end doc_epcs_status,dbo.doctors.NPI,  
	case when RRR.MessageId is null then '' else RRR.MessageId end MessageId,
	CASE WHEN RRR.HasMissMatch IS NULL  THEN 0 ELSE RRR.HasMissMatch END has_miss_match,
	RRR.MissMatchReason AS miss_match_reson,RRR.ChgType,
	CASE WHEN dbo.prescription_details.refills_prn IS NULL Or dbo.prescription_details.refills_prn=0 THEN -1 ELSE 4 END pharm_refill_type,  
	CASE WHEN dbo.prescription_details.refills_prn IS NULL THEN 0 ELSE dbo.prescription_details.refills_prn END refills_prn,  
	CASE WHEN dbo.prescriptions.DoPrintAfterPatHistory = 0 AND dbo.prescriptions.DoPrintAfterPatOrig = 0 AND dbo.prescriptions.DoPrintAfterPatCopy = 0 AND dbo.prescriptions.DoPrintAfterPatMonograph = 0 THEN 0 ELSE 1 END printOptionsSet,  
	prescription_details.hospice_drug_relatedness_id,prescription_details.drug_indication,
	CASE WHEN RRR.DocInfoText IS NULL THEN '' ELSE RRR.DocInfoText END disp_doc_info_text,
	dbo.prescription_details.order_reason,
	RRR.NoOfMedicationsRequested
	INTO #RecentRxChangeRequests
	FROM dbo.prescriptions WITH(READPAST) INNER JOIN dbo.prescription_details WITH(READPAST) ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id   
	INNER JOIN dbo.patients WITH(READPAST)  ON dbo.prescriptions.pa_id = dbo.patients.pa_id   
	INNER JOIN dbo.doctors WITH(READPAST) ON dbo.prescriptions.dr_id = dbo.doctors.dr_id
	INNER JOIN erx.RxChangeRequests RRR WITH(READPAST) ON  RRR.PresId = dbo.prescriptions.pres_id  
	WHERE (dbo.prescriptions.pres_approved_date IS NULL AND ISNULL(RRR.IsApproved,0)=0) AND (ISNULL(dbo.prescriptions.pres_void,0)=0 AND ISNULL(RRR.IsVoided,0)=0) AND 
	(((@IsRestrictToPersonalRx=1) AND ((@IsAgent=1 AND dbo.prescriptions.PRIM_DR_ID = @UserId) OR (@IsAgent<>1 AND dbo.prescriptions.DR_ID = @UserId)))
	OR ((@IsRestrictToPersonalRx<>1) AND (dbo.prescriptions.DG_ID = @DoctorGroupId)))
	AND PRES_PRESCRIPTION_TYPE = 5 AND dbo.prescriptions.pa_id = @PatientId  order by ChgReqId desc  

	;WITH ChangeRequestsInfo AS (
    SELECT RCI.*, 
           ROW_NUMBER() OVER(PARTITION BY RCI.ChgReqId 
                                 ORDER BY RCI.ChgReqInfoId ASC) AS rank
      FROM erx.RxChangeRequestsInfo RCI WITH(READPAST)
	INNER JOIN #RecentRxChangeRequests RRCR WITH(NOLOCK) ON RCI.ChgReqId = RRCR.ChgReqId
	)

	SELECT TOP 75 RRCR.ChgReqId, RRCR.PriorAuthNum, RRCR.dr_last_name, RRCR.dr_first_name, RRCR.dr_phone, RRCR.pa_id,   
	RRCR.pa_first, RRCR.pa_middle,RRCR.pa_flag, RRCR.pa_last, RRCR.pa_dob,RRCR.pa_sex,
	RRCR.pa_phone, RRCR.pa_ssn,RRCR.pres_id, RRCR.dg_id, RRCR.pres_entry_date,  
	RRCR.pres_read_date, RRCR.off_dr_list, RRCR.only_faxed, RRCR.pharm_id,   
	RRCR.agent_info,RRCR.supervisor_info,RRCR.prim_dr_id, RRCR.fax_conf_send_date, RRCR.fax_conf_numb_pages,  
	RRCR.fax_conf_remote_fax_id, RRCR.fax_conf_error_string, RRCR.pres_delivery_method,   
	RRCR.time_difference, RRCR.pres_approved_date, RRCR.dr_id, RRCR.pres_void,   
	RRCR.pres_void_comments, RRCR.ddid, RRCR.drug_name,   
	RRCR.pd_id, RRCR.dosage, RRCR.duration_amount,   
	RRCR.comments,RRCR.compound, RRCR.duration_unit,   
	RRCR.prn,RRCR.days_supply,
	RRCR.prn_description, RRCR.numb_refills,   
	RRCR.use_generic, RRCR.pres_prescription_type, dbo.pharmacies.pharm_company_name,   
	dbo.pharmacies.pharm_address1, dbo.pharmacies.pharm_address2, dbo.pharmacies.pharm_city, dbo.pharmacies.pharm_state,   
	dbo.pharmacies.pharm_zip, dbo.pharmacies.pharm_phone, dbo.pharmacies.pharm_fax,
	case when dbo.pharmacies.service_level IS null then 0 Else dbo.pharmacies.service_level END pharm_service_level,  
	RRCR.doc_epcs_status,RRCR.NPI,  
	case when RRCR.MessageId is null then '' else RRCR.MessageId end MessageId,
	RRCR.has_miss_match,
	RRCR.miss_match_reson,RRCR.ChgType,
	CASE WHEN RCI.Date1Enum=6 THEN RCI.Date1 WHEN RCI.Date2Enum=6 THEN RCI.Date2   
	WHEN RCI.Date3Enum=6 THEN RCI.Date3 ELSE '1901-01-01' END fill_date,   
	RRCR.pharm_refill_type,  
	RRCR.refills_prn,  
	CASE WHEN RCI.DRUGNAME IS NULL THEN '' ELSE RCI.DRUGNAME END REQUESTED_DRUG_NAME,  
	CASE WHEN RCI.QTY1 IS NULL THEN '' ELSE RCI.QTY1 END REQUESTED_QUANTITY,  
	CASE WHEN RCI.QTY1UNITS IS NULL THEN '' ELSE RCI.QTY1UNITS END REQUESTED_QUANTITY_UNITS,  
	CASE WHEN RCI.RefillsType IS NULL THEN 0 WHEN RCI.RefillsType=4 THEN 1 ELSE 0 END REQUESTED_REFILLS_PRN,  
	CASE WHEN RCI.REFILLS IS NULL THEN 0 ELSE RCI.REFILLS END REQUESTED_REFILLS,  
	CASE WHEN RCI.DOSAGE1 IS NULL THEN '' ELSE RCI.DOSAGE1 END REQUESTED_DOSAGE1,  
	CASE WHEN RCI.DOSAGE2 IS NULL THEN '' ELSE RCI.DOSAGE2 END REQUESTED_DOSAGE2,  
	CASE WHEN RCI.COMMENTS1 IS NULL THEN '' ELSE RCI.COMMENTS1 END REQUESTED_COMMENTS1,  
	CASE WHEN RCI.COMMENTS2 IS NULL THEN '' ELSE RCI.COMMENTS2 END REQUESTED_COMMENTS2,  
	CASE WHEN RCI.COMMENTS3 IS NULL THEN '' ELSE RCI.COMMENTS3 END REQUESTED_COMMENTS3,  
	CASE WHEN RCI.DAYSSUPPLY IS NULL THEN -1 ELSE RCI.DAYSSUPPLY END REQUESTED_DAYS_SUPPLY,
	RRCR.disp_doc_info_text,
	CASE WHEN RCI.DocInfoText IS NULL THEN '' ELSE RCI.DocInfoText END mn_doc_info_text,      
	CASE WHEN RCI.SubstitutionCode IS NULL THEN 1   
	WHEN (RCI.SubstitutionCode = 7 Or RCI.SubstitutionCode = 1) THEN 0 ELSE 1 END REQUESTED_USE_GENERIC,  
	RRCR.printOptionsSet,  
	CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END DRUGLEVEL,RRCR.hospice_drug_relatedness_id,hdr.Code,hdr.Description  ,RRCR.drug_indication,
	PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,PRIM_DOCS.time_difference AS PRIM_TIME_DIFF,
	dbo.pharmacies.ncpdp_numb AS Pharm_NCPDP, dbo.pharmacies.NPI AS Pharm_NPI
	,RRCR.NoOfMedicationsRequested,
	RCI.ChgReqInfoId  ChangeRequestInfoId,
	RRCR.order_reason
	FROM #RecentRxChangeRequests RRCR  
	LEFT OUTER JOIN Doctors PRIM_DOCS on RRCR.prim_dr_id = PRIM_DOCS.DR_ID    
	LEFT OUTER JOIN RMIID1 WITH(NOLOCK) ON RRCR.ddid = dbo.RMIID1.MEDID   
	LEFT OUTER JOIN dbo.pharmacies WITH(READPAST) ON RRCR.pharm_id = dbo.pharmacies.pharm_id 
	LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON RRCR.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id		  
	LEFT OUTER JOIN ChangeRequestsInfo RCI ON  RCI.ChgReqId=RRCR.ChgReqId AND RCI.rank = 1
	order by RRCR.ChgReqId desc  
	RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
