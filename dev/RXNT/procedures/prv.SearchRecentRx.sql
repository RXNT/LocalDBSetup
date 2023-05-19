SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[SearchRecentRx]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @PatientFirstName varchar(50)=NULL, @PatientLastName varchar(50)=NULL, @ShowOnlyCancelledRx bit=0
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @PreferredPrescriberId BIGINT = 0;
	
	SELECT @PreferredPrescriberId=di.staff_preferred_prescriber 
	FROM dbo.doctor_info di WITH(NOLOCK)
	WHERE di.dr_id=@UserId 
	
	IF(@PreferredPrescriberId>0)
	BEGIN
		SET @UserId = @PreferredPrescriberId;
		SET @IsRestrictToPersonalRx = 1;
	END

	IF @DoctorGroupId = 4 
	BEGIN
				SELECT TOP 75 doctors.dr_last_name, doctors.dr_first_name,doctors.time_difference, patients.pa_id, 
				patients.pa_first, patients.pa_middle, patients.pa_last, prescriptions.pres_id, 
				prescriptions.dr_id, prescriptions.prim_dr_id,  prescriptions.pres_approved_date, ph.pharm_id, ph.pharm_company_name,
				ph.pharm_address1, ph.pharm_address2, ph.pharm_city, ph.pharm_state, ph.pharm_zip, ph.pharm_phone,ph.pharm_fax,
				PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, 
				doctors.dg_id, prescription_details.drug_name, prescription_details.CANCEL_STATUS,prescription_details.CANCEL_STATUS_TEXT,prescription_details.dosage, 
				prescription_details.duration_amount, prescription_details.duration_unit, prescription_details.pd_id,  prescriptions.admin_notes, prescription_status.delivery_method, 
				prescription_status.response_type,  prescription_status.response_text, 
				prescription_status.cancel_req_response_date,prescription_status.cancel_req_response_type,prescription_status.cancel_req_response_text,				
				prescription_status.response_date,PE.pa_nick_name, (select COUNT (1)  FROM dbo.patients WITH (NOLOCK)
						 WHERE pa_id = prescriptions.pa_id AND ( 
						 pa_first IS NULL OR pa_first = '' OR
						 pa_last IS NULL OR pa_last = '' OR
						 pa_dob IS NULL OR pa_dob = '' OR
						 pa_sex IS NULL OR pa_sex = '' OR
						 pa_address1 IS NULL OR pa_address1 = '' OR
						 pa_zip IS NULL OR pa_zip = '' OR
						 pa_state IS NULL OR pa_state = '')
						 ) AS patient_details_missing FROM prescriptions WITH(NOLOCK) 
						 INNER JOIN patients WITH(NOLOCK) ON 
				prescriptions.pa_id = patients.pa_id 
				LEFT OUTER JOIN [patient_extended_details] PE WITH(NOLOCK) ON 
				PE.pa_id = patients.pa_id 
				INNER JOIN doctors WITH(NOLOCK) ON prescriptions.dr_id = 
				doctors.dr_id  INNER JOIN prescription_details WITH(NOLOCK) ON prescriptions.pres_id = 
				prescription_details.pres_id  LEFT OUTER JOIN prescription_status  WITH(NOLOCK) ON 
				prescription_details.pd_id = prescription_status.pd_id  LEFT OUTER JOIN DOCTORS 
				PRIM_DOCS WITH(NOLOCK) ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID 
				LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id WHERE 
				prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL)) 
				AND (prescriptions.pres_void = 0) AND doctors.dg_id =@DoctorGroupId AND 
				prescriptions.dg_id= @DoctorGroupId  AND (@PatientFirstName IS NULL OR patients.pa_first LIKE @PatientFirstName+'%')
				AND (@PatientLastName IS NULL OR patients.pa_last LIKE @PatientLastName+'%') AND (@ShowOnlyCancelledRx = 0 OR (@ShowOnlyCancelledRx=1 AND prescription_details.cancel_status IS NOT NULL))
				ORDER BY pres_approved_date DESC
	END
	ELSE
	BEGIN	
		IF @IsRestrictToPersonalRx = 1 
			BEGIN
				SELECT TOP 75 doctors.dr_last_name, doctors.dr_first_name,doctors.time_difference, patients.pa_id, 
				patients.pa_first, patients.pa_middle, patients.pa_last, ph.pharm_id, ph.pharm_company_name,
				ph.pharm_address1, ph.pharm_address2, ph.pharm_city, ph.pharm_state, ph.pharm_zip, ph.pharm_phone,ph.pharm_fax,
				prescriptions.pres_id, prescriptions.dr_id, prescriptions.prim_dr_id, 
				prescriptions.pres_approved_date,  doctors.dg_id, prescription_details.drug_name, prescription_details.CANCEL_STATUS,prescription_details.CANCEL_STATUS_TEXT,
				prescription_details.dosage, prescription_details.duration_amount, prescription_details.duration_unit, prescription_details.pd_id,  
				PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,
				prescriptions.admin_notes, prescription_status.delivery_method, 
				prescription_status.response_type,  prescription_status.response_text, 
				prescription_status.cancel_req_response_date,prescription_status.cancel_req_response_type,prescription_status.cancel_req_response_text,
				prescription_status.response_date,PE.pa_nick_name, (select COUNT (1)  FROM dbo.patients WITH (NOLOCK)
						 WHERE pa_id = prescriptions.pa_id AND ( 
						 pa_first IS NULL OR pa_first = '' OR
						 pa_last IS NULL OR pa_last = '' OR
						 pa_dob IS NULL OR pa_dob = '' OR
						 pa_sex IS NULL OR pa_sex = '' OR
						 pa_address1 IS NULL OR pa_address1 = '' OR
						 pa_zip IS NULL OR pa_zip = '' OR
						 pa_state IS NULL OR pa_state = '')
						 ) AS patient_details_missing FROM prescriptions WITH(NOLOCK) INNER JOIN patients WITH(NOLOCK)
				ON prescriptions.pa_id = patients.pa_id  LEFT OUTER JOIN [patient_extended_details] PE WITH(NOLOCK) ON 
				PE.pa_id = patients.pa_id INNER JOIN doctors WITH(NOLOCK) ON 
				prescriptions.dr_id = doctors.dr_id  INNER JOIN prescription_details  WITH(NOLOCK) ON 
				prescriptions.pres_id = prescription_details.pres_id  LEFT OUTER JOIN 
				prescription_status WITH(NOLOCK) ON prescription_details.pd_id = prescription_status.pd_id  
				LEFT OUTER JOIN DOCTORS PRIM_DOCS WITH(NOLOCK) ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID  
				LEFT OUTER JOIN PHARMACIES  PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id			
				WHERE prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL))
				AND (prescriptions.pres_void = 0) AND doctors.dr_id = @UserId AND 
				prescriptions.dr_id= @UserId  AND PRES_APPROVED_DATE > 
				dateadd(dd, -7, getdate())  AND (@PatientFirstName IS NULL OR patients.pa_first LIKE @PatientFirstName+'%')
				AND (@PatientLastName IS NULL OR patients.pa_last LIKE @PatientLastName+'%') AND (@ShowOnlyCancelledRx = 0 OR (@ShowOnlyCancelledRx=1 AND prescription_details.cancel_status IS NOT NULL))
				ORDER BY pres_approved_date DESC
			END
		ELSE
			BEGIN
				SELECT TOP 75 doctors.dr_last_name, doctors.dr_first_name,doctors.time_difference, patients.pa_id, 
				patients.pa_first, patients.pa_middle, patients.pa_last, PE.pa_nick_name,prescriptions.pres_id, 
				prescriptions.dr_id, prescriptions.prim_dr_id,  prescriptions.pres_approved_date, ph.pharm_id, ph.pharm_company_name,
				ph.pharm_address1, ph.pharm_address2, ph.pharm_city, ph.pharm_state, ph.pharm_zip, ph.pharm_phone,ph.pharm_fax,
				PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME, 
				doctors.dg_id, prescription_details.drug_name, prescription_details.dosage, prescription_details.duration_amount, prescription_details.duration_unit,
				prescription_details.CANCEL_STATUS,prescription_details.CANCEL_STATUS_TEXT,
				prescription_details.pd_id,  prescriptions.admin_notes, prescription_status.delivery_method, 
				prescription_status.response_type,  prescription_status.response_text, 
				prescription_status.cancel_req_response_date,prescription_status.cancel_req_response_type,prescription_status.cancel_req_response_text,
				prescription_status.response_date, (select COUNT (1)  FROM dbo.patients WITH (NOLOCK)
						 WHERE pa_id = prescriptions.pa_id AND ( 
						 pa_first IS NULL OR pa_first = '' OR
						 pa_last IS NULL OR pa_last = '' OR
						 pa_dob IS NULL OR pa_dob = '' OR
						 pa_sex IS NULL OR pa_sex = '' OR
						 pa_address1 IS NULL OR pa_address1 = '' OR
						 pa_zip IS NULL OR pa_zip = '' OR
						 pa_state IS NULL OR pa_state = '' )
						 ) AS patient_details_missing FROM prescriptions WITH(NOLOCK) INNER JOIN patients ON 
				prescriptions.pa_id = patients.pa_id 
				LEFT OUTER JOIN [patient_extended_details] PE WITH(NOLOCK) ON 
				PE.pa_id = patients.pa_id 
				INNER JOIN doctors WITH(NOLOCK) ON prescriptions.dr_id = 
				doctors.dr_id  INNER JOIN prescription_details WITH(NOLOCK) ON prescriptions.pres_id = 
				prescription_details.pres_id  LEFT OUTER JOIN prescription_status WITH(NOLOCK) ON 
				prescription_details.pd_id = prescription_status.pd_id  LEFT OUTER JOIN DOCTORS PRIM_DOCS WITH(NOLOCK) 
				 ON prescriptions.prim_dr_id = PRIM_DOCS.DR_ID 
				LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK) ON prescriptions.pharm_id = ph.pharm_id WHERE 
				prescriptions.off_dr_list=0 AND (NOT (prescriptions.pres_approved_date IS NULL)) 
				AND (prescriptions.pres_void = 0) AND doctors.dg_id =@DoctorGroupId AND 
				prescriptions.dg_id= @DoctorGroupId  AND PRES_APPROVED_DATE > 
				dateadd(dd, -7, getdate())  AND (@PatientFirstName IS NULL OR patients.pa_first LIKE @PatientFirstName+'%')
				AND (@PatientLastName IS NULL OR patients.pa_last LIKE @PatientLastName+'%') AND (@ShowOnlyCancelledRx = 0 OR (@ShowOnlyCancelledRx=1 AND prescription_details.cancel_status IS NOT NULL))
				ORDER BY pres_approved_date DESC
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
