SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rashhed
-- Create date: 24/11/2022
-- Description:	To get the Patient Medication
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SearchPatientActiveMedication_CMS68v11_NQF0419]  
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
	PAM_ID, A.DRUG_ID, R.MED_REF_DEA_CD drug_class,
		CASE WHEN A.DRUG_ID <= -1 THEN A.DRUG_NAME ELSE R.MED_MEDID_DESC END  DRUG_NAME,
		I.ETC_ID, I.ETC_NAME, DATE_ADDED, A.COMPOUND, A.COMMENTS, from_pd_id, A.record_source,A.order_reason,
		DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE,A.dosage, A.duration_amount,
		A.duration_unit, A.drug_comments, A.numb_refills, A.use_generic,
		A.days_supply, A.prn, A.prn_description, A.date_start, date_end, PD.MAX_DAILY_DOSAGE
		FROM cqm2022.PatientMedicationCodes pec WITH(NOLOCK)
		INNER JOIN PATIENT_ACTIVE_MEDS A WITH(NOLOCK) ON pec.MedicationId=A.pam_id
		LEFT OUTER JOIN prescription_details pd WITH(NOLOCK) ON pd.pd_id=A.from_pd_id
		LEFT OUTER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
		LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUG_ID = R.MEDID 
		LEFT OUTER JOIN RETCMED0 H WITH(NOLOCK) ON R.MEDID = H.MEDID 
		LEFT OUTER JOIN DBO.RETCTBL0 I WITH(NOLOCK) ON H.ETC_ID = I.ETC_ID
		LEFT OUTER JOIN DOCTORS DR WITH(NOLOCK) ON A.ADDED_BY_DR_ID = DR.DR_ID 
		LEFT OUTER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON R.MEDID = AD.MEDID
		INNER JOIN cqm2022.SysLookupCMS68v11_NQF0419 codes ON pec.Code = codes.Code AND pec.CodeSystemId = codes.CodeSystemId
		INNER JOIN cqm2022.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2022.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId AND vs.QDMCategoryId= 5 --Medication
		where pec.PatientId = @PatientId AND pec.MedicationId>0  AND PrescriptionId IS NULL
		
		SELECT pam_id AS ActiveMedId, pd.pd_id AS PrescriptionDetailId, pd.duration_amount As DurationAmount, pd.duration_unit AS DurationUnit FROM cqm2022.PatientMedicationCodes pec WITH(NOLOCK)
		INNER JOIN PATIENT_ACTIVE_MEDS A WITH(NOLOCK) ON pec.MedicationId=A.pam_id
		INNER JOIN prescription_details pd WITH(NOLOCK) ON A.drug_id=pd.ddid
		INNER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
		INNER JOIN cqm2022.SysLookupCMS68v11_NQF0419 codes ON pec.Code = codes.Code AND pec.CodeSystemId = codes.CodeSystemId
		WHERE A.pa_id=@PatientId AND p.pa_id=@PatientId AND pec.MedicationId>0  AND PrescriptionId IS NULL
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
