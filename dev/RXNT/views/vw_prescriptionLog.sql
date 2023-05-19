SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.vw_prescriptionLog
AS
SELECT     dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
                      dbo.prescriptions.pres_id, dbo.prescriptions.dg_id, dbo.prescriptions.pres_entry_date, dbo.prescriptions.pres_read_date, dbo.prescriptions.off_dr_list, 
                      dbo.prescriptions.only_faxed, dbo.prescriptions.pharm_id, dbo.prescriptions.prim_dr_id, dbo.prescriptions.fax_conf_send_date, 
                      dbo.prescriptions.fax_conf_numb_pages, dbo.prescriptions.fax_conf_remote_fax_id, dbo.prescriptions.fax_conf_error_string, 
                      dbo.prescriptions.pres_delivery_method, dbo.doctors.time_difference
FROM         dbo.prescriptions INNER JOIN
                      dbo.patients ON dbo.prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
                      dbo.doctors ON dbo.prescriptions.dr_id = dbo.doctors.dr_id
WHERE     (dbo.prescriptions.off_dr_list = 0) AND EXISTS
                          (SELECT     pres_id
                            FROM          prescription_details
                            WHERE      pres_id = prescriptions.pres_id)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
