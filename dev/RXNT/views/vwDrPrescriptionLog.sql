SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   VIEW [dbo].[vwDrPrescriptionLog]
AS

SELECT dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
dbo.prescriptions.pres_id, dbo.prescriptions.dr_id, dbo.prescriptions.prim_dr_id, dbo.prescriptions.pres_approved_date, dbo.doctors.dg_id
FROM dbo.prescriptions 
INNER JOIN dbo.patients ON prescriptions.pa_id = dbo.patients.pa_id 
INNER JOIN dbo.doctors ON prescriptions.dr_id = dbo.doctors.dr_id
WHERE (NOT (prescriptions.pres_approved_date IS NULL)) AND (prescriptions.pres_void = 0)
AND off_dr_list=0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
