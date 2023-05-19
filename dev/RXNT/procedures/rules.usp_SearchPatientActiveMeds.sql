SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	VINOD
Create date			:	14-MAR-2018
Description			:	This procedure is used to get applogin salt
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [rules].[usp_SearchPatientActiveMeds]	
	@PatientId			BIGINT	
AS
BEGIN
	
	WITH TEMP AS (select ROW_NUMBER() over (partition by PA.drug_id order by  EVD_EXT_VOCAB_TYPE_ID ASC,EVD_EXT_VOCAB_ID DESC) as RowNum,
		PA.drug_id, EVD_EXT_VOCAB_ID as EVD_EXT_VOCAB_ID, EVD_EXT_VOCAB_TYPE_ID
		from patient_active_meds PA WITH(NOLOCK)
		inner join REVDEL0 R1 WITH(NOLOCK) on PA.drug_id=R1.EVD_FDB_VOCAB_ID AND EVD_FDB_VOCAB_TYPE_ID = 3 AND EVD_EXT_VOCAB_TYPE_ID in(501,502)
		where pa_id =  @PatientId
	),
	TEMP1 AS (
	SELECT drug_id, EVD_EXT_VOCAB_ID = STUFF((
		SELECT ', ' + CASE WHEN EVD_EXT_VOCAB_TYPE_ID = 501 THEN '(SCD)' ELSE '(SBD)' END + EVD_EXT_VOCAB_ID FROM TEMP
		WHERE drug_id = x.drug_id
		FOR XML PATH(''), TYPE).value('.[1]', 'nvarchar(max)'), 1, 2, ''),
		EVD_EXT_VOCAB_ID AS RxNormCodeId
	FROM TEMP AS x
	WHERE RowNum=1
	GROUP BY drug_id,EVD_EXT_VOCAB_ID
	)
	SELECT DISTINCT PAM_ID, A.DRUG_ID, R.MED_REF_DEA_CD drug_class,
		CASE WHEN A.DRUG_ID <= -1 THEN A.DRUG_NAME ELSE R.MED_MEDID_DESC END  DRUG_NAME,
		I.ETC_ID, I.ETC_NAME, DATE_ADDED, A.COMPOUND, A.COMMENTS, from_pd_id, A.record_source,A.order_reason,
		DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE,A.dosage, A.duration_amount,
		A.duration_unit, A.drug_comments, A.numb_refills, A.use_generic,
		A.days_supply, A.prn, A.prn_description, A.date_start, date_end,
		case when A.rxnorm_code is null OR A.rxnorm_code = ''         
			then qry.EVD_EXT_VOCAB_ID         
			else A.rxnorm_code 
			end as RxNormCode,
		AD.MEDID ACTIVEDDID, p.pres_prescription_type,
		A.last_modified_date,
		qry.RxNormCodeId,pd.icd9_desc
		FROM PATIENT_ACTIVE_MEDS A WITH(NOLOCK)
		LEFT OUTER JOIN prescription_details pd WITH(NOLOCK) ON pd.pd_id=A.from_pd_id
		LEFT OUTER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
		LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUG_ID = R.MEDID 
		LEFT OUTER JOIN RETCMED0 H WITH(NOLOCK) ON R.MEDID = H.MEDID 
		LEFT OUTER JOIN DBO.RETCTBL0 I WITH(NOLOCK) ON H.ETC_ID = I.ETC_ID
		LEFT OUTER JOIN DOCTORS DR WITH(NOLOCK) ON A.ADDED_BY_DR_ID = DR.DR_ID 
		LEFT OUTER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON R.MEDID = AD.MEDID
		LEFT JOIN TEMP1 qry on qry.drug_id = A.drug_id
	WHERE A.PA_ID = @PatientId AND (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1) 
	ORDER BY A.pam_id DESC, DATE_ADDED DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
