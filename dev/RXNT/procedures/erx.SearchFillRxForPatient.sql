SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 13-OCT-2017
-- Description:	Search Fill Rx for Patient
-- =============================================
CREATE PROCEDURE [erx].[SearchFillRxForPatient]
	@PatientId int
AS
BEGIN
		
	SELECT TOP 75 rxfill.FillReqId,rxfill.FillStatus,rxfill.FillStatusType,
				  CASE WHEN rxfillInfo.Date1Enum=6 THEN rxfillInfo.Date1 WHEN rxfillInfo.Date2Enum=6 THEN rxfillInfo.Date2   
				  WHEN rxfillInfo.Date3Enum=6 THEN rxfillInfo.Date3 ELSE '1901-01-01' END fill_date,
				  A.pres_id, A.pres_delivery_method, A.pres_entry_date, A.pres_approved_date, B.pd_id, B.ddid, B.drug_name, B.dosage, B.use_generic, B.numb_refills, B.comments, 
				  B.duration_amount, B.duration_unit, B.prn, B.as_directed, - 1 AS status, B.history_enabled, A.pa_id, A.dg_id, C.pharm_company_name, 
				  C.pharm_address1, C.pharm_city, C.pharm_state, C.pharm_zip, C.pharm_phone, D.dr_last_name, D.dr_first_name, D.dr_prefix, 
				  E.dr_last_name AS agent_last, E.dr_first_name AS agent_first, A.pres_void_comments, D.time_difference, A.prim_dr_id, D.dr_id, rxfill.DocInfoText
	FROM erx.RxFillRequests rxfill WITH(NOLOCK)
	INNER JOIN erx.RxFillRequestsInfo rxfillInfo WITH(NOLOCK) ON rxfill.FillReqId=rxfillInfo.FillReqId
	INNER JOIN prescriptions A WITH(NOLOCK) ON rxfill.PresId=A.pres_id
	INNER JOIN prescription_details B WITH(NOLOCK) ON A.pres_id=B.pres_id AND rxfill.FillReqId=B.FillReqId
	LEFT OUTER JOIN pharmacies C WITH(NOLOCK) ON A.pharm_id=C.pharm_id
	INNER JOIN doctors D WITH(NOLOCK) ON D.dr_id=A.dr_id
	LEFT OUTER JOIN doctors E WITH(NOLOCK) ON E.dr_id=A.prim_dr_id
	WHERE A.pa_id=@PatientId --AND pres_prescription_type=6
	UNION ALL
	SELECT TOP 75 rxfill.FillReqId,rxfill.FillStatus,rxfill.FillStatusType,
				  CASE WHEN rxfillInfo.Date1Enum=6 THEN rxfillInfo.Date1 WHEN rxfillInfo.Date2Enum=6 THEN rxfillInfo.Date2   
				  WHEN rxfillInfo.Date3Enum=6 THEN rxfillInfo.Date3 ELSE '1901-01-01' END fill_date,
				  rxfill.PresId AS pres_id, rxfill.DeliveryMethod AS pres_delivery_method,
				  CASE WHEN rxfillInfo.Date1Enum=2 THEN rxfillInfo.Date1 WHEN rxfillInfo.Date2Enum=2 THEN rxfillInfo.Date2   
				  WHEN rxfillInfo.Date3Enum=2 THEN rxfillInfo.Date3 ELSE '1901-01-01' END AS pres_approved_date,
				  NULL AS pres_entry_date, NULL AS pd_id, NULL AS ddid, rxfill.DrugName AS drug_name, rxfill.Dosage1 AS dosage, NULL AS use_generic, rxfill.Refills AS numb_refills, rxfill.Comments1 AS comments, 
				  rxfill.Qty1 AS duration_amount, rxfill.Qty1Units AS duration_unit, NULL AS prn, NULL AS as_directed, - 1 AS status, NULL AS history_enabled, rxfill.PatientId AS pa_id, rxfill.DoctorGroupId  AS dg_id, NULL AS pharm_company_name, 
				  NULL AS pharm_address1, NULL AS pharm_city, NULL AS pharm_state, NULL AS pharm_zip, NULL AS pharm_phone, D.dr_last_name, D.dr_first_name, D.dr_prefix, 
				  NULL AS agent_last, NULL AS agent_first, NULL AS pres_void_comments, NULL AS time_difference, NULL AS prim_dr_id, D.dr_id, rxfill.DocInfoText
	FROM erx.RxFillRequests rxfill WITH(NOLOCK)
	INNER JOIN erx.RxFillRequestsInfo rxfillInfo WITH(NOLOCK) ON rxfill.FillReqId=rxfillInfo.FillReqId
	INNER JOIN doctors D WITH(NOLOCK) ON D.dr_id=rxfill.DoctorId
	WHERE rxfill.PatientId=@PatientId AND rxfill.PresId<=0
	ORDER BY FillReqId DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
