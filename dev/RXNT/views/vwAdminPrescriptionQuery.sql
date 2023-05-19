SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwAdminPrescriptionQuery]
AS
SELECT     dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
    prescriptions.pres_id, prescriptions.dg_id, prescriptions.pres_entry_date, response_date, response_type, prescriptions.pharm_id, prescriptions.prim_dr_id, 
    confirmation_id, response_text, admin_notes, prescriptions.pres_delivery_method, delivery_method, prescriptions.pres_approved_date, prescriptions.pres_void, prescriptions.dr_id,prescriptions.pres_prescription_type, 
    prescription_details.pd_id, drug_name, dosage, duration_amount, duration_unit, numb_refills, comments, use_generic, prescription_status.queued_date
  FROM 	dbo.prescriptions INNER JOIN dbo.prescription_details ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id
    LEFT OUTER JOIN prescription_status ON prescription_details.pd_id = prescription_status.pd_id
    INNER JOIN dbo.patients ON prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
    dbo.doctors ON prescriptions.dr_id = dbo.doctors.dr_id
  WHERE (NOT (prescriptions.pres_approved_date IS NULL))
    AND dbo.prescriptions.sfi_is_sfi = 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
