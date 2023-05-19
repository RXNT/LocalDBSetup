SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	21-OCT-2017
Description			:	Search Patient Past medication
Last Modified By	:	Samip Neupane	
Last Modifed Date	:	12/03/2022
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SearchPatientPastHxMedication] 
	@PatientId			BIGINT,
	@DoctorCompanyId    BIGINT
AS
BEGIN
	SELECT DISTINCT PatientPastHxMedicationId, A.DRUGID, R.MED_REF_DEA_CD drugclass,
	CASE WHEN A.DRUGID <= -1 THEN A.DRUGNAME ELSE R.MED_MEDID_DESC END  DRUGNAME,
	I.ETC_ID, I.ETC_NAME, CreatedDate,  A.COMMENTS, PrescriptionDetailId, A.RecordSource,A.Reason,
	DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE,A.dosage, A.DurationAmount,A.Active,
	A.DurationUnit, A.DrugComments, A.UseGeneric,A.numb_refills,
	A.DaysSupply, A.prn, A.PrnDescription, A.DateStart, A.DateEnd,
	A.RxNormCode, AD.MEDID ACTIVEDDID, p.pres_prescription_type,A.visibility_hidden_to_patient
	FROM PatientPastHxMedication A WITH(NOLOCK)
	LEFT OUTER JOIN prescription_details pd WITH(NOLOCK) ON pd.pd_id=A.PrescriptionDetailId
	LEFT OUTER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
	LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUGID = R.MEDID 
	LEFT OUTER JOIN RETCMED0 H WITH(NOLOCK) ON R.MEDID = H.MEDID 
	LEFT OUTER JOIN DBO.RETCTBL0 I WITH(NOLOCK) ON H.ETC_ID = I.ETC_ID
	LEFT OUTER JOIN DOCTORS DR WITH(NOLOCK) ON A.CreatedBy = DR.DR_ID 
	LEFT OUTER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON R.MEDID = AD.MEDID
WHERE A.PatientId = @PatientId AND (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1) 
ORDER BY A.PatientPastHxMedicationId DESC, CreatedDate DESC

END
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
