SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	05-JAN-2018
-- Description:		Generate Daily Prescriptions Report
-- =============================================
CREATE PROCEDURE [dbo].[GenerateDailyPrescriptionsReport]
	@PartnerId					BIGINT=NULL
AS
BEGIN
 DECLARE @FromDate DATETIME
 DECLARE @ToDate DATETIME
 SET @FromDate=  CAST(CURRENT_TIMESTAMP-1 AS DATE)
 SET @ToDate = DATEADD(DAY,1,@FromDate)
  
	SELECT	PD.pd_id AS RxNTId,
			P.pa_ssn AS ChartNo,
			P.pa_id AS RxNTPatientId,
			P.pa_last + ', ' + P.pa_first AS PatientName,
			P.pa_sex AS Gender,
			P.pa_dob AS PatientDOB,
			D.dr_last_name+ ', ' +D.dr_first_name AS StaffUserCreatedRx,
			Do.dr_last_name+ ', ' +Do.dr_first_name AS ProviderApprovedRx,
			Do.NPI AS ProivderNPI,
			Do.dr_dea_numb AS ProviderDEA,
			dg.dg_name AS GroupName,
			PD.drug_name AS Medication,
			NdC.NDC,
			PD.dosage AS Instructions,
			PH.pharm_company_name AS PharmacyName,
			PR.pres_approved_date AS PrescriptionApprovedDate
	FROM [dbo].[prescription_details] PD WITH(NOLOCK)
	INNER JOIN [dbo].[prescriptions] PR ON PD.pres_id = PR.pres_id
	INNER JOIN [dbo].[pharmacies] PH  WITH(NOLOCK) ON PH.pharm_id = PR.pharm_id
	INNER JOIN [dbo].[patients] P  WITH(NOLOCK) ON P.pa_id = PR.pa_id
	INNER JOIN [dbo].[doctors] D WITH(NOLOCK) ON D.dr_id = PR.prim_dr_id
	INNER JOIN [dbo].[doctors] DO WITH(NOLOCK) ON DO.dr_id = PR.dr_id
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id=PR.dg_id
	INNER JOIN [dbo].[doc_companies] DC WITH(NOLOCK) ON DC.dc_id = DG.dc_id
	LEFT OUTER JOIN (SELECT MEDID,RNM.NDC,
					row_number()over(partition by MEDID ORDER BY medid) as RN
		FROM RNMMIDNDC RNM WITH(NOLOCK)) NDC ON 
		NDC.MEDID=PD.ddid AND NDC.RN=1
	WHERE DC.partner_id=@PartnerId
	AND PR.pres_approved_date BETWEEN @FromDate AND @ToDate
 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
