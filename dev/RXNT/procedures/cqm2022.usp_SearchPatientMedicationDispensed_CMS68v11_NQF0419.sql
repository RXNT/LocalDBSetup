SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rashhed
-- Create date: 24/11/2022
-- Description:	To get the Patient Medication Dispensed
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SearchPatientMedicationDispensed_CMS68v11_NQF0419]  
	@PatientId BIGINT,	
	@DoctorId BIGINT,	
	@StartDate Date,
	@EndDate Date	
AS
BEGIN
	 DECLARE @RequestId BIGINT
	 SELECT @RequestId = MAX(RequestId) FROM  cqm2022.[DoctorCQMCalculationRequest] R 
	 WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1
	 IF @RequestId>0
	 BEGIN
		SELECT DISTINCT  pec.Code,vs.ValueSetOID,cs.CodeSystemOID,pec.PerformedFromDate,ISNULL(pec.PerformedToDate,pec.PerformedFromDate) AS PerformedToDate ,
		pres.PRES_ID, pres.PRES_ENTRY_DATE, pres.PRES_APPROVED_DATE, pres.PRES_VOID, 
		pres.ELIGIBILITY_CHECKED, pres.ELIGIBILITY_TRANS_ID, pres.PRINT_OPTIONS, pres.PRES_VOID_CODE, pres.IS_SIGNED, 
		pres.PRES_PRESCRIPTION_TYPE, pres.PRES_DELIVERY_METHOD, pres.PRES_VOID_COMMENTS, pres.ADMIN_NOTES, 
		pres.PHARM_ID, pres.PA_ID, pres.DR_ID, pres.PRIM_DR_ID, pres.AUTHORIZING_DR_ID, pres.PRES_START_DATE, pres.PRES_END_DATE, 
		PD.PD_ID, PD.DDID, PD.DRUG_NAME, PD.DOSAGE, PD.MAX_DAILY_DOSAGE, PD.USE_GENERIC, PD.NUMB_REFILLS, CASE WHEN PD.REFILLS_PRN IS NULL THEN 0 ELSE PD.REFILLS_PRN END REFILLS_PRN, 
		PD.DURATION_AMOUNT, PD.DURATION_UNIT, PD.COMMENTS, PD.PRN, 
		PD.INCLUDE_IN_PRINT, PD.DAYS_SUPPLY, PD.INCLUDE_IN_PHARM_DELIVER, PD.SCRIPT_GUIDE_STATUS, PD.SCRIPT_GUIDE_ID, 
		PD.AS_DIRECTED, PD.ICD9,  PD.PRN_DESCRIPTION, PD.COMPOUND, 
		PD.SCRIPT_GUIDE_STATUS, PD.SCRIPT_GUIDE_ID, PD.INCLUDE_IN_PRINT, PD.INCLUDE_IN_PHARM_DELIVER, PD.order_reason AS ORDER_REASON 	
		FROM cqm2022.PatientMedicationCodes pec WITH(NOLOCK)
		INNER JOIN dbo.prescriptions pres WITH(NOLOCK) ON pec.PrescriptionId = pres.pres_id
		INNER JOIN patients WITH(NOLOCK) ON 
		pres.pa_id = patients.pa_id INNER JOIN doctors WITH(NOLOCK) ON pres.dr_id = 
		doctors.dr_id  INNER JOIN prescription_details pd WITH(NOLOCK) ON pres.pres_id = 
		pd.pres_id  LEFT OUTER JOIN prescription_status  WITH(NOLOCK) ON 
		pd.pd_id = prescription_status.pd_id  
		LEFT OUTER JOIN DOCTORS  PRIM_DOCS WITH(NOLOCK) ON pres.prim_dr_id = PRIM_DOCS.DR_ID 
		LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK) ON pres.pharm_id = ph.pharm_id  
		INNER JOIN cqm2022.SysLookupCMS68v11_NQF0419 codes ON pec.Code = codes.Code AND pec.CodeSystemId = codes.CodeSystemId
		INNER JOIN cqm2022.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2022.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId AND vs.QDMCategoryId= 5 --Medication
		where pec.PatientId = @PatientId  
		AND pres.pres_approved_date IS NOT NULL AND pres.pres_void=0 AND pd.history_enabled=1 AND ISNULL(pd.is_dispensed,0)=1
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
