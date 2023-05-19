SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To search the patient medications
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE   PROCEDURE [enc].[usp_SearchPatientMedications]
	@PatientId BIGINT,
	@ActiveOnly  BIT = 1
AS

BEGIN
	SET NOCOUNT ON;
	IF @ActiveOnly = 1
	BEGIN
		SELECT DISTINCT PAM_ID, 
						A.DRUG_ID, 
						R.MED_REF_DEA_CD drug_class,
						CASE 
							WHEN A.DRUG_ID <= -1 THEN A.DRUG_NAME 
							ELSE R.MED_MEDID_DESC 
						END  DRUG_NAME,
						I.ETC_ID, 
						I.ETC_NAME, 
						DATE_ADDED, 
						COMPOUND, 
						COMMENTS, 
						from_pd_id, 
						A.record_source,
						DR.DR_FIRST_NAME, 
						DR.DR_LAST_NAME, 
						AD.IS_ACTIVE,dosage, 
						duration_amount,
						duration_unit, 
						drug_comments, 
						numb_refills, 
						use_generic,
						days_supply, 
						prn, 
						prn_description, 
						date_start, 
						date_end,
						case 
							when A.rxnorm_code is null OR A.rxnorm_code = '' then qry.EVD_EXT_VOCAB_ID         
							else A.rxnorm_code 
						end as rxnorm_code,
						AD.MEDID ACTIVEDDID
		FROM PATIENT_ACTIVE_MEDS A 
		LEFT OUTER JOIN RMIID1 R ON A.DRUG_ID = R.MEDID 
		LEFT OUTER JOIN RETCMED0 H ON R.MEDID = H.MEDID
		LEFT OUTER JOIN DBO.RETCTBL0 I ON H.ETC_ID = I.ETC_ID
		LEFT OUTER JOIN DOCTORS DR ON A.ADDED_BY_DR_ID = DR.DR_ID
		LEFT OUTER JOIN ACTIVE_DRUGS AD ON R.MEDID = AD.MEDID
		left join (
					select PA.drug_id, max(EVD_EXT_VOCAB_ID) as EVD_EXT_VOCAB_ID
					from patient_active_meds PA WITH(NOLOCK)
					inner join REVDEL0 R1 WITH(NOLOCK) on PA.drug_id=R1.EVD_FDB_VOCAB_ID
					and EVD_FDB_VOCAB_TYPE_ID = 3
					AND EVD_EXT_VOCAB_TYPE_ID = 501
					where pa_id =  @PatientId
					group by PA.drug_id
				  ) qry on qry.drug_id = A.drug_id
		WHERE A.PA_ID = @PatientId
		AND (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1)
		ORDER BY DRUG_NAME DESC
	END
	ELSE
	BEGIN
		SELECT  DISTINCT PAM_ID, 
				DRUG_ID, 
				R.MED_REF_DEA_CD drug_class, 
				CASE DRUG_ID 
					WHEN -1 THEN A.DRUG_NAME 
					ELSE R.MED_MEDID_DESC 
				END DRUG_NAME, 
				I.ETC_ID, 
				I.ETC_NAME, 
				DATE_ADDED, 
				COMPOUND, 
				COMMENTS,
				from_pd_id,
				DR.DR_FIRST_NAME, 
				DR.DR_LAST_NAME, 
				AD.IS_ACTIVE,
				A.rxnorm_code
		FROM PATIENT_ACTIVE_MEDS A INNER JOIN RMIID1 R ON A.DRUG_ID = R.MEDID  
		LEFT OUTER JOIN RETCMED0 H ON R.MEDID = H.MEDID  
		LEFT OUTER JOIN  DBO.RETCTBL0 I ON H.ETC_ID = I.ETC_ID 
		INNER JOIN DOCTORS DR ON A.ADDED_BY_DR_ID = DR.DR_ID
		INNER JOIN ACTIVE_DRUGS AD ON R.MEDID = AD.MEDID 
		WHERE A.PA_ID = @PatientId AND (H.ETC_DEFAULT_USE_IND = 1  OR H.ETC_DEFAULT_USE_IND IS NULL) 
		ORDER BY DRUG_NAME DESC
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
