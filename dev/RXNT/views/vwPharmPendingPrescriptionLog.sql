SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW vwPharmPendingPrescriptionLog
AS
  SELECT dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
    prescriptions.pres_id, prescriptions.dg_id, pres_entry_date, delivery_method, prescriptions.prim_dr_id, pharm_id, 
    dbo.doctors.time_difference, pres_approved_date, pres_void, prescriptions.dr_id, 
    prim_docs.dr_first_name AS prim_dr_first_name, prim_docs.dr_last_name AS prim_dr_last_name, prescription_details.pd_id, drug_name, dosage,
    duration_amount, duration_unit, numb_refills, comments, use_generic
  FROM prescriptions INNER JOIN prescription_details ON prescriptions.pres_id = prescription_details.pres_id INNER JOIN 
    prescription_status ON prescription_details.pd_id = prescription_status.pd_id INNER JOIN
    dbo.patients ON prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
    dbo.doctors ON prescriptions.dr_id = dbo.doctors.dr_id LEFT OUTER JOIN
    dbo.doctors prim_docs ON prescriptions.prim_dr_id = prim_docs.dr_id
  WHERE (pres_void = 0) AND (pres_approved_date IS NOT NULL) AND (delivery_method = 0x02) AND 
    ((response_date IS NULL) OR (response_date IS NOT NULL AND response_type = 1))
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
