SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	13-JUNE-2016
Description			:	This procedure is used to Get Patient Active Med by Medication Id
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE  PROCEDURE [ehr].[usp_GetPatientActiveMedication]	
	@PatientId			BIGINT,
	@MedicationId		BIGINT
AS
BEGIN
	SELECT DISTINCT PAM_ID, A.DRUG_ID, R.MED_REF_DEA_CD drug_class,
	CASE WHEN A.DRUG_ID <= -1 THEN A.DRUG_NAME ELSE R.MED_MEDID_DESC END  DRUG_NAME,
	I.ETC_ID, I.ETC_NAME, DATE_ADDED, COMPOUND, COMMENTS, order_reason,from_pd_id, A.record_source,
	DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE,dosage, duration_amount,
	duration_unit, drug_comments, order_reason,numb_refills, use_generic,
	days_supply, prn, prn_description, date_start, date_end,
	qry.EVD_EXT_VOCAB_ID as RxNormCode, AD.MEDID ACTIVEDDID
	FROM PATIENT_ACTIVE_MEDS A 
	LEFT OUTER JOIN RMIID1 R ON A.DRUG_ID = R.MEDID 
	LEFT OUTER JOIN RETCMED0 H ON R.MEDID = H.MEDID 
	LEFT OUTER JOIN DBO.RETCTBL0 I ON H.ETC_ID = I.ETC_ID
	LEFT OUTER JOIN DOCTORS DR ON A.ADDED_BY_DR_ID = DR.DR_ID 
	LEFT OUTER JOIN ACTIVE_DRUGS AD ON R.MEDID = AD.MEDID
	LEFT JOIN (
		select PA.drug_id, max(EVD_EXT_VOCAB_ID) as EVD_EXT_VOCAB_ID
		from patient_active_meds PA WITH(NOLOCK)
		inner join REVDEL0 R1 WITH(NOLOCK) on PA.drug_id=R1.EVD_FDB_VOCAB_ID AND EVD_FDB_VOCAB_TYPE_ID = 3 AND EVD_EXT_VOCAB_TYPE_ID = 501
		where pa_id =  @PatientId
		group by PA.drug_id
		) qry on qry.drug_id = A.drug_id
WHERE A.PA_ID = @PatientId AND (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1) AND pam_id = @MedicationId
ORDER BY DATE_ADDED DESC, A.pam_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
