SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  VIEW [dbo].[vwPrescriptionStatusAuxillaryLog]
AS
SELECT C.pres_id, B.pd_id, C.admin_notes, delivery_method, response_type, response_text, response_date, confirmation_id, 
    drug_name, dosage, duration_amount, duration_unit, numb_refills, comments, use_generic, C.dg_id, 
    C.pa_id, C.pres_entry_date, C.pres_approved_date, C.off_dr_list, C.pharm_id FROM prescription_status A WITH(NOLOCK)
    RIGHT OUTER JOIN prescription_details B WITH(NOLOCK) ON A.pd_id = B.pd_id INNER JOIN prescriptions C WITH(NOLOCK) ON 
    B.pres_id = C.pres_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
