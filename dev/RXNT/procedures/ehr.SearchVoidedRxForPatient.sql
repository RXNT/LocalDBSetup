SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 1/10/2017
-- Description:	Created for RS-4851: Base is [dbo].[FetchVoidedRxForPatient] 
-- =============================================
CREATE PROCEDURE [ehr].[SearchVoidedRxForPatient]
	@patId int
AS
BEGIN
	SELECT     A.pres_id, A.pres_delivery_method, A.pres_entry_date, A.pres_approved_date, B.pd_id, B.ddid, B.drug_name, B.dosage, B.use_generic, B.numb_refills, B.comments, 
                      B.duration_amount, B.duration_unit, B.prn, B.as_directed, - 1 AS status, B.history_enabled, A.pa_id, A.dg_id, C.pharm_company_name, 
                      C.pharm_address1, C.pharm_city, C.pharm_state, C.pharm_zip, C.pharm_phone, D.dr_last_name, D.dr_first_name, D.dr_prefix, 
                      E.dr_last_name AS agent_last, E.dr_first_name AS agent_first, A.pres_void_comments, D.time_difference, A.prim_dr_id, D.dr_id
		FROM   dbo.prescriptions A INNER JOIN
                      dbo.prescription_details B ON A.pres_id = B.pres_id LEFT OUTER JOIN
                      dbo.pharmacies C ON A.pharm_id = C.pharm_id INNER JOIN
                      dbo.doctors D ON D.dr_id = A.dr_id LEFT OUTER JOIN
                      dbo.doctors E ON E.dr_id = A.prim_dr_id
WHERE    ((A.pres_approved_date IS NOT NULL) AND (A.pres_void <> 0) --AND (A.prim_dr_id <> A.dr_id OR A.prim_dr_id = 0) 
OR (A.pres_approved_date IS NOT NULL) AND (A.pres_void <> 0) AND (A.pres_prescription_type <> 1)) AND pa_id = @patId
order by pres_approved_date desc	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
