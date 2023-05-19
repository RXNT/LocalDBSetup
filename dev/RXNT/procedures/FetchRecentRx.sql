SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchRecentRx]
	@DoctorId int, @DoctorGroupId int, @bRestrictToPersonalRx bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	IF @DoctorGroupId = 4 
	BEGIN
				SELECT TOP 75 doctors.dr_last_name, doctors.dr_first_name, patients.pa_id, doctors.time_difference, 
				patients.pa_first, patients.pa_middle, patients.pa_last, prescriptions.pres_id, 
				prescriptions.dr_id, prescriptions.prim_dr_id,  prescriptions.pres_approved_date, ph.pharm_id, ph.pharm_company_name,
				ph.pharm_address1, ph.pharm_address2, ph.pharm_city, ph.pharm_state, ph.pharm_zip, ph.pharm_phone,ph.pharm_fax,
				PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, 
				doctors.dg_id, prescription_details.drug_name, prescription_details.CANCEL_STATUS,prescription_details.CANCEL_STATUS_TEXT,prescription_details.dosage, 
				prescription_details.pd_id,  prescriptions.admin_notes, prescription_status.delivery_method, 
				prescription_status.response_type,  prescription_status.response_text, 
				prescription_status.cancel_req_response_date,prescription_status.cancel_req_response_type,prescription_status.cancel_req_response_text,				
				prescription_status.response_date,prescription_details.hospice_drug_relatedness_id,hdr.Code,hdr.Description,prescription_details.drug_indication  FROM prescriptions WITH(NOLOCK) INNER JOIN patients WITH(NOLOCK) ON 
				prescriptions.pa_id = patients.pa_id INNER JOIN doctors WITH(NOLOCK) ON prescriptions.dr_id = 
				doctors.dr_id  INNER JOIN prescription_details WITH(NOLOCK) ON prescriptions.pres_id = 
				prescription_details.pres_id  LEFT OUTER JOIN prescription_status  WITH(NOLOCK) ON 
				prescription_details.pd_id = prescription_status.pd_id  LEFT OUTER JOIN DOCTORS 
				PRIM_DOCS WITH(NOLOCK) ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID 
				LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id 
				LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON prescription_details.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id
				WHERE 
				prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL)) 
				AND (prescriptions.pres_void = 0) AND doctors.dg_id =@DoctorGroupId AND 
				prescriptions.dg_id= @DoctorGroupId  ORDER BY pres_approved_date DESC
	END
	ELSE
	BEGIN	
		IF @bRestrictToPersonalRx = 1 
			BEGIN
				SELECT TOP 75 doctors.dr_last_name, doctors.dr_first_name, patients.pa_id, doctors.time_difference, 
				patients.pa_first, patients.pa_middle, patients.pa_last, ph.pharm_id, ph.pharm_company_name,
				ph.pharm_address1, ph.pharm_address2, ph.pharm_city, ph.pharm_state, ph.pharm_zip, ph.pharm_phone,ph.pharm_fax,
				prescriptions.pres_id, prescriptions.dr_id, prescriptions.prim_dr_id, 
				prescriptions.pres_approved_date,  doctors.dg_id, prescription_details.drug_name, prescription_details.CANCEL_STATUS,prescription_details.CANCEL_STATUS_TEXT,
				prescription_details.dosage, prescription_details.pd_id,  
				PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,
				prescriptions.admin_notes, prescription_status.delivery_method, 
				prescription_status.response_type,  prescription_status.response_text, 
				prescription_status.cancel_req_response_date,prescription_status.cancel_req_response_type,prescription_status.cancel_req_response_text,
				prescription_status.response_date,prescription_details.hospice_drug_relatedness_id,hdr.Code,hdr.Description,prescription_details.drug_indication  FROM prescriptions WITH(NOLOCK) INNER JOIN patients WITH(NOLOCK)
				ON prescriptions.pa_id = patients.pa_id  INNER JOIN doctors WITH(NOLOCK) ON 
				prescriptions.dr_id = doctors.dr_id  INNER JOIN prescription_details  WITH(NOLOCK) ON 
				prescriptions.pres_id = prescription_details.pres_id  LEFT OUTER JOIN 
				prescription_status WITH(NOLOCK) ON prescription_details.pd_id = prescription_status.pd_id  
				LEFT OUTER JOIN DOCTORS PRIM_DOCS WITH(NOLOCK) ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID  
				LEFT OUTER JOIN PHARMACIES  PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id	
				LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON prescription_details.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id		
				WHERE prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL))
				AND (prescriptions.pres_void = 0) AND doctors.dr_id = @DoctorId AND 
				prescriptions.dr_id= @DoctorId  AND PRES_APPROVED_DATE > 
				dateadd(dd, -7, getdate())  ORDER BY pres_approved_date DESC
			END
		ELSE
			BEGIN
				SELECT TOP 75 doctors.dr_last_name, doctors.dr_first_name, patients.pa_id, doctors.time_difference, 
				patients.pa_first, patients.pa_middle, patients.pa_last, prescriptions.pres_id, 
				prescriptions.dr_id, prescriptions.prim_dr_id,  prescriptions.pres_approved_date, ph.pharm_id, ph.pharm_company_name,
				ph.pharm_address1, ph.pharm_address2, ph.pharm_city, ph.pharm_state, ph.pharm_zip, ph.pharm_phone,ph.pharm_fax,
				PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, 
				doctors.dg_id, prescription_details.drug_name, prescription_details.dosage, 
				prescription_details.CANCEL_STATUS,prescription_details.CANCEL_STATUS_TEXT,
				prescription_details.pd_id,  prescriptions.admin_notes, prescription_status.delivery_method, 
				prescription_status.response_type,  prescription_status.response_text, 
				prescription_status.cancel_req_response_date,prescription_status.cancel_req_response_type,prescription_status.cancel_req_response_text,
				prescription_status.response_date,prescription_details.hospice_drug_relatedness_id,hdr.Code,hdr.Description,prescription_details.drug_indication  FROM prescriptions WITH(NOLOCK) INNER JOIN patients ON 
				prescriptions.pa_id = patients.pa_id INNER JOIN doctors WITH(NOLOCK) ON prescriptions.dr_id = 
				doctors.dr_id  INNER JOIN prescription_details WITH(NOLOCK) ON prescriptions.pres_id = 
				prescription_details.pres_id  LEFT OUTER JOIN prescription_status WITH(NOLOCK) ON 
				prescription_details.pd_id = prescription_status.pd_id  LEFT OUTER JOIN DOCTORS PRIM_DOCS WITH(NOLOCK) 
				 ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID 
				LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id 
				LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON prescription_details.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id		
				WHERE 
				prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL)) 
				AND (prescriptions.pres_void = 0) AND doctors.dg_id =@DoctorGroupId AND 
				prescriptions.dg_id= @DoctorGroupId  AND PRES_APPROVED_DATE > 
				dateadd(dd, -7, getdate())  ORDER BY pres_approved_date DESC
			END
		END   
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
