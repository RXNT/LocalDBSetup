SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	27-10-2017
Description			:	Search Patient Past medication
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE   PROCEDURE [enc].[usp_SearchPatientPastHxMedicationForPatientEncounter] 
	@PatientId			BIGINT,
	@DoctorCompanyId    BIGINT
AS
BEGIN
	
	SELECT DISTINCT PatientPastHxMedicationId, 
					A.DRUGID, 
					R.MED_REF_DEA_CD drugclass,
					CASE 
						WHEN A.DRUGID <= -1 THEN A.DRUGNAME 
						ELSE R.MED_MEDID_DESC 
					END  DRUGNAME,
					I.ETC_ID, 
					I.ETC_NAME, 
					CreatedDate,  
					A.COMMENTS, 
					PrescriptionDetailId, 
					A.RecordSource,A.Reason,
					DR.DR_FIRST_NAME, 
					DR.DR_LAST_NAME, 
					AD.IS_ACTIVE,
					A.dosage, 
					A.DurationAmount,
					A.DurationUnit, 
					A.DrugComments, 
					A.UseGeneric,
					A.DaysSupply, 
					A.prn, 
					A.PrnDescription, 
					A.DateStart, 
					A.DateEnd,
					case 
						when A.RxNormCode is null OR A.RxNormCode = '' then qry.EVD_EXT_VOCAB_ID         
						else A.RxNormCode 
					end as RxNormCode,
					qry.EVD_EXT_VOCAB_ID as RxNormCode, 
					AD.MEDID ACTIVEDDID, 
					p.pres_prescription_type
	FROM ehr.PatientPastHxMedication A WITH(NOLOCK)
	LEFT OUTER JOIN prescription_details pd WITH(NOLOCK) ON pd.pd_id=A.PrescriptionDetailId
	LEFT OUTER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
	LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUGID = R.MEDID 
	LEFT OUTER JOIN RETCMED0 H WITH(NOLOCK) ON R.MEDID = H.MEDID 
	LEFT OUTER JOIN DBO.RETCTBL0 I WITH(NOLOCK) ON H.ETC_ID = I.ETC_ID
	LEFT OUTER JOIN DOCTORS DR WITH(NOLOCK) ON A.CreatedBy = DR.DR_ID 
	LEFT OUTER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON R.MEDID = AD.MEDID
	LEFT JOIN (
		select PA.drug_id, max(EVD_EXT_VOCAB_ID) as EVD_EXT_VOCAB_ID
		from patient_active_meds PA WITH(NOLOCK)
		inner join REVDEL0 R1 WITH(NOLOCK) on PA.drug_id=R1.EVD_FDB_VOCAB_ID AND EVD_FDB_VOCAB_TYPE_ID = 3 AND EVD_EXT_VOCAB_TYPE_ID = 501
		where pa_id =  @PatientId
		group by PA.drug_id
		) qry on qry.drug_id = A.drugid
WHERE A.PatientId = @PatientId AND (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1) 
ORDER BY A.PatientPastHxMedicationId DESC, CreatedDate DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
