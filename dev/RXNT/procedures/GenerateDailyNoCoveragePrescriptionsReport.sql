SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	05-JAN-2018
-- Description:		Generate Daily Prescriptions Report
-- =============================================
CREATE PROCEDURE [dbo].[GenerateDailyNoCoveragePrescriptionsReport]
	@PartnerId	BIGINT
AS
BEGIN
	 DECLARE @FromDate DATETIME
	 DECLARE @ToDate DATETIME
	 SET @FromDate=  CAST(CURRENT_TIMESTAMP-1 AS DATE)
	 PRINT @FromDate
	 SET @ToDate = DATEADD(DAY,1,@FromDate)
 
 
  
		SELECT  
		PRLog.PresLogId AS RxNTId,
		P.pa_ssn AS ChartNo,
		P.pa_id AS RxNTPatientId,
		P.pa_last + ', ' + P.pa_first AS PatientName,
		P.pa_sex AS Gender,
		P.pa_dob AS PatientDOB,
		D.dr_last_name+ ', ' +D.dr_first_name AS StaffUserCreatedRx,
		Do.dr_last_name+ ', ' +Do.dr_first_name AS ProviderApprovedRx,
		Do.NPI AS ProivderNPI,
		Do.dr_dea_numb AS ProviderDEA,
		DG.dg_name AS GroupName,
		Pres.drug_name AS Medication,
		NdC.NDC,
		Pres.pd_id AS RxNTPrescriptionId,
		Pres.dosage AS Instructions,
		Pres.pharm_company_name AS PharmacyName,
		Pres.pres_approved_date AS PrescriptionApprovedDate 
		FROM 
		dbo.NonFormularyPrescriptionsLog PRLog 
		INNER JOIN [dbo].[patients] P  WITH(NOLOCK) ON P.pa_id = PRLog.PatientId
		INNER JOIN [dbo].[doctors] D WITH(NOLOCK) ON D.dr_id = PRLog.PrimDoctorId
		INNER JOIN [dbo].[doctors] DO WITH(NOLOCK) ON DO.dr_id = PRLog.DoctorId
		INNER JOIN [dbo].[doc_groups] DG WITH(NOLOCK) ON DG.dg_id = D.dg_id
		INNER JOIN [dbo].[doc_companies] DC WITH(NOLOCK) ON DC.dc_id = DG.dc_id
		LEFT OUTER JOIN (SELECT Pres.prim_dr_id,Pres.pa_id,pd.ddid,pres.dr_id,MAX(pres_entry_date) AS pres_entry_date,MAX(PD.drug_name) AS drug_name,
			MAX(pd.pd_id) pd_id,
			MAX(pd.dosage) dosage,
			MAX(ph.pharm_company_name) pharm_company_name,
			MAX(Pres.pres_approved_date) pres_approved_date
			FROM [dbo].[prescriptions] Pres
			INNER JOIN prescription_details PD WITH(NOLOCK) ON PD.pres_id=pres.pres_id 
			LEFT OUTER JOIN [dbo].[pharmacies] PH  WITH(NOLOCK) ON PH.pharm_id = Pres.pharm_id
			WHERE Pres.pres_entry_date BETWEEN @FromDate AND @ToDate
			GROUP BY Pres.prim_dr_id,Pres.pa_id,pd.ddid,pres.dr_id
		) AS Pres ON  PRLog.DoctorId=Pres.dr_id AND PRLog.PrimDoctorId=Pres.prim_dr_id AND PRLog.PatientId=Pres.pa_id AND PRLog.MedId=Pres.ddid AND DATEDIFF(hour, PRLog.CreatedDate, Pres.pres_entry_date) BETWEEN 0 and 24
		LEFT OUTER JOIN (SELECT MEDID,RNM.NDC,
					row_number()over(partition by MEDID ORDER BY medid) as RN
		FROM RNMMIDNDC RNM WITH(NOLOCK)) NDC ON 
		NDC.MEDID=PRLog.MedId AND NDC.RN=1
		WHERE dc.partner_id=@PartnerId
		AND PRLog.CreatedDate BETWEEN @FromDate AND @ToDate
		--GROUP BY PRLog.PresLogId ,P.pa_ssn,P.pa_id,P.pa_last,P.pa_first,P.pa_sex ,P.pa_dob ,D.dr_last_name,D.dr_first_name ,Do.dr_last_name+ ', ' +Do.dr_first_name,
		--	DG.dg_name, Pres.drug_name,NdC.NDC
 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
