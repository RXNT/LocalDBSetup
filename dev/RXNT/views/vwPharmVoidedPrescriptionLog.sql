SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.vwPharmVoidedPrescriptionLog
AS
SELECT     dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
                      dbo.prescriptions.pres_id, dbo.prescriptions.dg_id, dbo.prescriptions.pres_entry_date, dbo.prescriptions.off_pharm_list, dbo.prescriptions.pharm_id, 
                      dbo.prescriptions.prim_dr_id, dbo.prescriptions.pres_approved_date, dbo.prescriptions.pres_void, dbo.prescriptions.dr_id, 
                      prim_docs.dr_first_name AS prim_dr_first_name, prim_docs.dr_last_name AS prim_dr_last_name, dbo.prescription_details.pd_id, 
                      dbo.prescription_details.drug_name, dbo.prescription_details.duration_amount, dbo.prescription_details.duration_unit, 
                      dbo.prescription_details.comments, dbo.prescription_details.use_generic, dbo.prescription_details.dosage, dbo.prescription_details.numb_refills, 
                      dbo.prescriptions.pres_void_comments
FROM         dbo.prescriptions INNER JOIN
                      dbo.prescription_details ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id INNER JOIN
                      dbo.patients ON dbo.prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
                      dbo.doctors ON dbo.prescriptions.dr_id = dbo.doctors.dr_id INNER JOIN
                      dbo.doctors prim_docs ON dbo.prescriptions.prim_dr_id = prim_docs.dr_id
WHERE     (dbo.prescriptions.pres_void <> 0) AND (dbo.prescriptions.off_pharm_list = 0) AND (dbo.prescriptions.sfi_is_sfi = 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
