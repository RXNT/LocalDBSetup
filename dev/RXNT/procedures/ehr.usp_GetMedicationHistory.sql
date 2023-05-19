SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	21-JUNE-2016
Description			:	This procedure is used to Get Patient med History
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetMedicationHistory]
	@PatientMedHxId BIGINT
AS
BEGIN
	 SELECT DISTINCT PAM_ID, DRUG_ID, R.MED_REF_DEA_CD drug_class, CASE DRUG_ID WHEN -1 THEN A.DRUG_NAME ELSE R.MED_MEDID_DESC END DRUG_NAME, I.ETC_ID, I.ETC_NAME, DATE_ADDED, COMPOUND, COMMENTS,A.order_reason,from_pd_id,
	 DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE, A.dosage, a.duration_amount, a.duration_unit, a.numb_refills, a.drug_comments,a.use_generic,a.prn,a.prn_description,a.days_supply,a.date_start,a.date_end,a.record_source 
	 FROM patient_medications_hx A WITH(NOLOCK)
	 INNER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUG_ID = R.MEDID 
	 LEFT OUTER JOIN  RETCMED0 H WITH(NOLOCK) ON R.MEDID = H.MEDID 
	 LEFT OUTER JOIN  DBO.RETCTBL0 I WITH(NOLOCK) ON H.ETC_ID = I.ETC_ID 
	 INNER JOIN DOCTORS DR WITH(NOLOCK) ON A.ADDED_BY_DR_ID = DR.DR_ID
	 INNER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON R.MEDID = AD.MEDID WHERE A.pam_id = @PatientMedHxId AND (H.ETC_DEFAULT_USE_IND = 1  OR H.ETC_DEFAULT_USE_IND IS NULL)
	 ORDER BY DRUG_NAME DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
