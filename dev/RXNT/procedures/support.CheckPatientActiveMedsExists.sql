SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CheckPatientActiveMedsExists]
/* 
	EXEC [support].[CheckPatientActiveMedsExists] 
	@RxNTPatientId = <Enter RxNT Patient Id here>,		-- Required
	@DrugName = '<Enter drug name here>'				-- Optional
	GO
*/
@RxNTPatientId BIGINT, 
@DrugName VARCHAR(100)=NULL 
AS
	 
	WITH TEMP AS (select ROW_NUMBER() over (partition by PA.drug_id order by  EVD_EXT_VOCAB_TYPE_ID ASC,EVD_EXT_VOCAB_ID DESC) as RowNum,
		PA.drug_id, EVD_EXT_VOCAB_ID as EVD_EXT_VOCAB_ID, EVD_EXT_VOCAB_TYPE_ID
		from patient_active_meds PA WITH(NOLOCK)
		inner join REVDEL0 R1 WITH(NOLOCK) on PA.drug_id=R1.EVD_FDB_VOCAB_ID AND EVD_FDB_VOCAB_TYPE_ID = 3 AND EVD_EXT_VOCAB_TYPE_ID in(501,502)
		where pa_id =  @RxNTPatientId
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
	SELECT DISTINCT PAM_ID RxNTPatientActiveMedId, A.DRUG_ID RxNTDrugId,-- R.MED_REF_DEA_CD drug_class,
		CASE WHEN A.DRUG_ID <= -1 THEN A.DRUG_NAME ELSE R.MED_MEDID_DESC END  DrugName,
		CASE WHEN A.COMPOUND=1 THEN 'Yes' ELSE 'No' END Compound, A.COMMENTS Comments, from_pd_id RxNTPrescriptionId
		,--A.record_source,A.order_reason,
		DR.DR_FIRST_NAME DoctorFirstName, DR.DR_LAST_NAME DoctorLastName, CASE WHEN AD.IS_ACTIVE=1 THEN 'Yes' ELSE 'No' END Active,A.dosage Dosage, A.duration_amount Quantity,
		A.duration_unit QuantityUnit, A.drug_comments Comments, A.numb_refills Refills, CASE WHEN A.use_generic=1 THEN 'Yes' ELSE 'No' END UseGeneric,
		A.days_supply DaysSupply, CASE WHEN A.prn = 1 THEN 'Yes' ELSE 'No' END PRN
		,A.prn_description PRNDescription, CONVERT(VARCHAR(20),A.date_start,101) StartDate, CONVERT(VARCHAR(20),date_end,101) EndDate,
		case when A.rxnorm_code is null OR A.rxnorm_code = ''         
			then qry.EVD_EXT_VOCAB_ID         
			else A.rxnorm_code 
			end as RxNormCode,
		DATE_ADDED AddedDate,
		A.last_modified_date LastModifiedOn,
		qry.RxNormCodeId,pd.icd9_desc ICDDescription
		FROM PATIENT_ACTIVE_MEDS A WITH(NOLOCK)
		LEFT OUTER JOIN prescription_details pd WITH(NOLOCK) ON pd.pd_id=A.from_pd_id
		LEFT OUTER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
		LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUG_ID = R.MEDID 
		LEFT OUTER JOIN RETCMED0 H WITH(NOLOCK) ON R.MEDID = H.MEDID 
		LEFT OUTER JOIN DBO.RETCTBL0 I WITH(NOLOCK) ON H.ETC_ID = I.ETC_ID
		LEFT OUTER JOIN DOCTORS DR WITH(NOLOCK) ON A.ADDED_BY_DR_ID = DR.DR_ID 
		LEFT OUTER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON R.MEDID = AD.MEDID
		LEFT JOIN TEMP1 qry on qry.drug_id = A.drug_id
	WHERE A.PA_ID = @RxNTPatientId AND (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1)
	AND (@DrugName IS NULL OR CASE WHEN A.DRUG_ID <= -1 THEN A.DRUG_NAME ELSE R.MED_MEDID_DESC END LIKE @DrugName+'%')
	ORDER BY A.pam_id DESC, DATE_ADDED DESC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
