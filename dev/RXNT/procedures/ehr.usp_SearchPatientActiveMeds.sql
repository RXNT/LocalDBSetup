SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	06-JUNE-2016
Description			:	This procedure is used to get applogin salt
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[usp_SearchPatientActiveMeds]	
	@PatientId			BIGINT	
AS
BEGIN
;WITH Pat_Active_MedTemp AS (
	SELECT DISTINCT PAM_ID, A.DRUG_ID, 
		A.DRUG_NAME,
		DATE_ADDED, A.COMPOUND, A.COMMENTS, from_pd_id, A.record_source,A.order_reason,
		A.dosage, A.duration_amount,
		A.duration_unit, A.drug_comments, A.numb_refills, A.use_generic,
		A.days_supply, A.prn, A.prn_description, A.date_start, date_end,
		A.rxnorm_code ,
		A.last_modified_date,
		A.ADDED_BY_DR_ID,
		A.visibility_hidden_to_patient
		FROM PATIENT_ACTIVE_MEDS A WITH(NOLOCK)
		 
	WHERE A.PA_ID = @PatientId
	)
	
	SELECT DISTINCT PAM_ID, A.DRUG_ID, R.MED_REF_DEA_CD drug_class,
		CASE WHEN A.DRUG_ID <= -1 THEN A.DRUG_NAME ELSE R.MED_MEDID_DESC END  DRUG_NAME,
		I.ETC_ID, I.ETC_NAME, DATE_ADDED, A.COMPOUND, A.COMMENTS, from_pd_id, A.record_source,A.order_reason,
		DR.DR_FIRST_NAME, DR.DR_LAST_NAME, CASE WHEN dgfm.dgfm_id>0 THEN dgfm.is_active ELSE AD.IS_ACTIVE END IS_ACTIVE,A.dosage, A.duration_amount,
		A.duration_unit, A.drug_comments, A.numb_refills, A.use_generic,
		A.days_supply, A.prn, A.prn_description, A.date_start, date_end,
		case when A.rxnorm_code is null OR A.rxnorm_code = ''         
			then qry.EVD_EXT_VOCAB_ID         
			else A.rxnorm_code 
			end as RxNormCode,
		AD.MEDID ACTIVEDDID, p.pres_prescription_type,
		A.last_modified_date,
		qry.EVD_EXT_VOCAB_ID RxNormCodeId,pd.icd9_desc,A.visibility_hidden_to_patient
		FROM Pat_Active_MedTemp A WITH(NOLOCK)
		LEFT OUTER JOIN prescription_details pd WITH(NOLOCK) ON pd.pd_id=A.from_pd_id
		LEFT OUTER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
		LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUG_ID = R.MEDID 
		LEFT OUTER JOIN RETCMED0 H WITH(NOLOCK) ON R.MEDID = H.MEDID 
		LEFT OUTER JOIN DBO.RETCTBL0 I WITH(NOLOCK) ON H.ETC_ID = I.ETC_ID
		LEFT OUTER JOIN DOCTORS DR WITH(NOLOCK) ON A.ADDED_BY_DR_ID = DR.DR_ID 
		LEFT OUTER JOIN doc_group_freetext_meds dgfm WITH(NOLOCK) ON pd.ddid=dgfm.drug_id AND dgfm.dg_id=DR.dg_id
		LEFT OUTER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON R.MEDID = AD.MEDID
		LEFT OUTER JOIN dbo.Cust_REVDEL0 qry ON  qry.EVD_FDB_VOCAB_ID= A.drug_id  
	WHERE  (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1) 
	ORDER BY A.pam_id DESC, DATE_ADDED DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
