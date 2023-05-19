SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	29-OCT-2018
-- Description:		Search ERX Error Report
-- =============================================
CREATE PROCEDURE [erx].[SearchPartnereRxErrorReport]
  @PartnerId			BIGINT
 
AS
BEGIN
	SELECT PD.pd_id as RxNTId,
	P.pa_ssn as PatientId,DG.dc_id ,
	D.dr_last_name+ ' ' +D.dr_first_name as StaffUserCreatedRx,
	Do.dr_last_name+ ' ' +Do.dr_first_name as ProviderApprovedRx,
	PD.drug_name Medication,
	PD.dosage Instructions,
	PS.response_text as ErrorResponse,
	PH.pharm_company_name as PharmacyName,
	PR.pres_approved_date
  FROM [dbo].[prescription_status] PS WITH(NOLOCK)
  INNER JOIN [dbo].[prescription_details] PD ON PS.pd_id = PD.pd_id
  INNER JOIN [dbo].[prescriptions] PR ON PD.pres_id = PR.pres_id
  INNER JOIN [dbo].[pharmacies] PH  WITH(NOLOCK) ON PH.pharm_id = PR.pharm_id
  INNER JOIN [dbo].[patients] P  WITH(NOLOCK) ON P.pa_id = PR.pa_id
  INNER JOIN [dbo].[doc_groups] DG WITH(NOLOCK) ON DG.dg_id = PR.dg_id
  INNER JOIN [dbo].[doc_companies] DC WITH(NOLOCK) ON DC.dc_id = DG.dc_id
  INNER JOIN [dbo].[doctors] D WITH(NOLOCK) ON D.dr_id = PR.prim_dr_id
  INNER JOIN [dbo].[doctors] DO WITH(NOLOCK) ON DO.dr_id = PR.dr_id
where 
1 = 1
AND DC.partner_id=@PartnerId
AND PS.delivery_method = 262144
AND PS.response_type = 1 
AND PR.pres_approved_date >= dateadd(day,datediff(day,1,GETDATE()),0)
AND PR.pres_approved_date < dateadd(day,datediff(day,0,GETDATE()),0)
END   
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
