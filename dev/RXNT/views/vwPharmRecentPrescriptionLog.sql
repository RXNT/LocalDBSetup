SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW vwPharmRecentPrescriptionLog
AS
  SELECT     dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
    prescriptions.pres_id, prescriptions.dg_id, prescriptions.pres_entry_date, prescription_status.response_date, prescriptions.off_pharm_list, 
    prescriptions.pharm_id, prescriptions.prim_dr_id, prescriptions.pres_approved_date, 
    prescriptions.dr_id, prim_docs.dr_first_name AS prim_dr_first_name, prim_docs.dr_last_name AS prim_dr_last_name, prescription_details.pd_id, drug_name, dosage,
    duration_amount, duration_unit, numb_refills, comments, use_generic
  FROM 	dbo.prescriptions INNER JOIN dbo.prescription_details ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id
    INNER JOIN dbo.prescription_status ON prescription_details.pd_id = prescription_status.pd_id
    INNER JOIN dbo.patients ON prescriptions.pa_id = dbo.patients.pa_id 
    INNER JOIN dbo.doctors ON prescriptions.dr_id = dbo.doctors.dr_id
    INNER JOIN dbo.doctors prim_docs ON prescriptions.prim_dr_id = prim_docs.dr_id
  WHERE (prescriptions.pres_void = 0) AND (prescriptions.pres_approved_date IS NOT NULL) AND 
    (delivery_method = 0x02) AND off_pharm_list = 0 AND dbo.prescriptions.sfi_is_sfi = 0 AND response_date IS NOT NULL AND response_type = 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
