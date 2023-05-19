SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.vwAdminPresLog
AS
SELECT     TOP 100 PERCENT dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, 
                      dbo.patients.pa_last, A.pres_id, A.pres_entry_date, A.pres_read_date, A.dr_id, A.off_dr_list, A.only_faxed, A.pharm_id, A.fax_conf_send_date, 
                      A.fax_conf_numb_pages, A.fax_conf_remote_fax_id, A.fax_conf_error_string, A.pres_delivery_method, Z.pharm_fax
FROM         dbo.prescriptions A INNER JOIN
                      dbo.patients ON A.pa_id = dbo.patients.pa_id INNER JOIN
                      dbo.doctors ON A.dr_id = dbo.doctors.dr_id INNER JOIN
                          (SELECT     pharm_id, pharm_fax
                            FROM          pharmacies
                            UNION
                            (SELECT     0, 'Print-Only'
                             FROM         pharmacies)) Z ON A.pharm_id = Z.pharm_id
WHERE     (A.pres_id >
                          (SELECT     MAX(pres_id) - 100
                            FROM          dbo.prescriptions))
ORDER BY A.pres_id DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
