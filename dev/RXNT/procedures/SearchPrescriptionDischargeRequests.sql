SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Balaji Jogi
-- Create date: 14-October-2016
-- Description:	Get the Prescription Discharge Requests 
-- =============================================
CREATE PROCEDURE [dbo].[SearchPrescriptionDischargeRequests]   
	-- Add the parameters for the stored procedure here
	@DoctorId bigint,
	@LoggedInUserId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT DR.discharge_request_id, dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id,   
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
	prescription_details.hospice_drug_relatedness_id,hdr.Code,hdr.Description,prescription_details.drug_indication, 
	case when dbo.doctors.epcs_enabled is null then 0 else dbo.doctors.epcs_enabled end doc_epcs_status,dbo.doctors.NPI,  
	CASE WHEN dbo.prescription_details.refills_prn IS NULL Or dbo.prescription_details.refills_prn=0 THEN -1 ELSE 4 END pharm_refill_type,  
	CASE WHEN dbo.prescription_details.refills_prn IS NULL THEN 0 ELSE dbo.prescription_details.refills_prn END refills_prn, 
	CASE WHEN dbo.prescriptions.DoPrintAfterPatHistory = 0 AND dbo.prescriptions.DoPrintAfterPatOrig = 0 AND dbo.prescriptions.DoPrintAfterPatCopy = 0 AND dbo.prescriptions.DoPrintAfterPatMonograph = 0 THEN 0 ELSE 1 END printOptionsSet 
	FROM dbo.prescriptions WITH(READPAST) 
	INNER JOIN dbo.prescription_details WITH(READPAST) ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id 
	LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON prescription_details.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id  
	INNER JOIN dbo.patients WITH(READPAST)  ON dbo.prescriptions.pa_id = dbo.patients.pa_id   
	INNER JOIN dbo.doctors WITH(READPAST) ON dbo.prescriptions.dr_id = dbo.doctors.dr_id   
	INNER JOIN dbo.prescription_discharge_requests DR WITH(READPAST) ON dbo.prescriptions.pres_id = DR.pres_id
	WHERE DR.approved_by IS NULL AND DR.Approved_On IS NULL AND DR.is_active=1 AND (DR.requested_to=@DoctorId OR dr.created_by=@LoggedInUserId)
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
