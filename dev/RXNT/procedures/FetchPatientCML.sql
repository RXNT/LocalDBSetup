SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Rasheed
Create date			:	18-November-2016
Description			:	Retrive patient current medication list
Last Modified By	:	Prabhash H
Last Modifed Date	:	12-October-2017
=======================================================================================
*/

CREATE PROCEDURE [dbo].[FetchPatientCML]
	@pa_id	INT
AS
BEGIN

	SELECT DISTINCT A.pres_id PAM_ID, B.ddid AS DRUG_ID, R.MED_REF_DEA_CD drug_class,
	CASE WHEN B.ddid <= -1 THEN B.drug_name ELSE R.MED_MEDID_DESC END  DRUG_NAME, 
	I.ETC_ID, I.ETC_NAME, 
	A.pres_entry_date DATE_ADDED, COMPOUND, COMMENTS, B.pd_id from_pd_id, NULL AS record_source,
	DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE,B.dosage, duration_amount, 
	duration_unit, B.comments AS drug_comments, numb_refills, use_generic, 
	days_supply, prn, B.prn_description, NULL AS date_start, NULL AS date_end, 
	 NormCodes.RxNormCode, AD.MEDID ACTIVEDDID
	,hdr.hospice_drug_relatedness_id,hdr.Code,hdr.Description,vwGCN.GCN_SEQNO, B.drug_indication
	, CASE WHEN (SELECT COUNT(1) FROM prescription_discharge_requests pddr WITH(NOLOCK) WHERE pddr.pres_id=A.pres_id AND pddr.is_active=1 )>0 THEN 1 ELSE 0 END IsDischargeRequested
	FROM prescriptions A WITH(NOLOCK)	
		INNER JOIN prescription_details B WITH(NOLOCK) ON A.pres_id = B.pres_id
		LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON	B.ddid = R.MEDID 
		LEFT OUTER JOIN vwMedGCN vwGCN WITH(NOLOCK) ON R.MEDID  = vwGCN.MEDID
		LEFT OUTER JOIN DOCTORS DR ON A.dr_id = DR.DR_ID
		LEFT OUTER JOIN ACTIVE_DRUGS AD ON R.MEDID = AD.MEDID
		LEFT OUTER JOIN
		( 
			SELECT H.MEDID, MAX(I.ETC_ID) ETC_ID,MAX(I.ETC_NAME) ETC_NAME
			FROM RETCMED0 H WITH(NOLOCK)
				LEFT OUTER JOIN DBO.RETCTBL0 I ON			H.ETC_ID = I.ETC_ID
			GROUP BY H.MEDID
		) I on R.MEDID = I.MEDID
		LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) 
			ON B.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id
		LEFT OUTER JOIN vwRxNormCodes NormCodes WITH(NOLOCK) ON NormCodes.Medid = B.ddid
	WHERE A.PA_ID = @pa_id
		AND A.PRES_APPROVED_DATE  IS NOT NULL
		AND (A.pres_void = 0 or A.pres_void is null)
		AND B.history_enabled = 1
	ORDER BY DRUG_NAME DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
