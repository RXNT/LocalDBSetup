SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.vwPrescriptionQuery
AS
SELECT     dbo.prescriptions.pres_id, dbo.prescriptions.dr_id, dbo.prescriptions.pharm_id, dbo.prescriptions.pa_id, dbo.prescriptions.pres_entry_date, 
                      dbo.pharmacies.pharm_company_name, dbo.pharmacies.pharm_fax, dbo.doctors.dr_first_name, dbo.doctors.dr_middle_initial, 
                      dbo.doctors.dr_last_name, dbo.doctors.dr_prefix, dbo.doctors.dr_suffix, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
                      dbo.prescriptions.pres_approved_date, dbo.prescriptions.pres_void, dbo.doctors.dr_state
FROM         dbo.prescriptions INNER JOIN
                      dbo.doctors ON dbo.prescriptions.dr_id = dbo.doctors.dr_id INNER JOIN
                      dbo.patients ON dbo.prescriptions.pa_id = dbo.patients.pa_id LEFT OUTER JOIN
                      dbo.pharmacies ON dbo.prescriptions.pharm_id = dbo.pharmacies.pharm_id
WHERE     (dbo.prescriptions.sfi_is_sfi = 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
