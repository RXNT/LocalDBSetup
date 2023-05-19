SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 2016/18/Nov
-- Description	: Fetch the patient CML
-- =============================================
CREATE PROCEDURE [dbo].[FetchPatientCMLForService]
	@pa_id int
AS
BEGIN
	SELECT DISTINCT A.pres_id PAM_ID, B.ddid AS DRUG_ID, R.MED_REF_DEA_CD drug_class,
	CASE WHEN B.ddid <= -1 THEN B.drug_name ELSE R.MED_MEDID_DESC END  DRUG_NAME, 
	I.ETC_ID, I.ETC_NAME, 
	A.pres_entry_date DATE_ADDED, COMPOUND, COMMENTS, B.pd_id from_pd_id, NULL AS record_source,
	DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE,wCML.dosage, duration_amount, 
	duration_unit, B.comments AS drug_comments, numb_refills, use_generic, 
	days_supply, prn, wCML.prn_description, NULL AS date_start, NULL AS date_end, 
	qry.EVD_EXT_VOCAB_ID as RxNormCode, AD.MEDID ACTIVEDDID
	,hdr.hospice_drug_relatedness_id,hdr.Code,hdr.Description,vwGCN.GCN_SEQNO
	FROM prescriptions A  WITH(NOLOCK)
	INNER JOIN 
	(
			SELECT MIN(p.pres_id) AS pres_id,p.pa_id,pd.dosage,
			pd.drug_indication prn_description FROM 
			prescriptions p WITH(NOLOCK)
			INNER JOIN prescription_details pd WITH(NOLOCK) ON p.pres_id = pd.pres_id
			LEFT OUTER JOIN prescription_discharge_requests pdr WITH(NOLOCK) 
			ON pdr.pres_id = pd.pres_id AND pdr.approved_by>0
			--WHERE pd.history_enabled!=0 AND pdr.discharge_request_id IS NULL
			WHERE P.pa_id > 0 and P.dr_id > 0 AND PD.pres_id > 0 AND pa_id = @pa_id
			AND P.pres_approved_date is not null
			AND (P.pres_void = 0 or P.pres_void is null)
			AND pd.history_enabled!=0 AND pdr.discharge_request_id IS NULL
			GROUP BY p.pa_id,pd.ddid,pd.dosage,pd.drug_indication
	) wCML ON A.pres_id = wCML.pres_id
	INNER JOIN prescription_details B WITH(NOLOCK) ON	A.pres_id = B.pres_id
	LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON			B.ddid = R.MEDID 
	LEFT OUTER JOIN vwMedGCN vwGCN WITH(NOLOCK) ON		R.MEDID = vwGCN.MEDID
	LEFT OUTER JOIN DOCTORS DR ON						A.prim_dr_id = DR.DR_ID
	LEFT OUTER JOIN ACTIVE_DRUGS AD ON					R.MEDID = AD.MEDID
	LEFT OUTER JOIN
	( 
		SELECT H.MEDID, MAX(I.ETC_ID) ETC_ID,MAX(I.ETC_NAME) ETC_NAME
		FROM RETCMED0 H WITH(NOLOCK)
			LEFT OUTER JOIN DBO.RETCTBL0 I ON			H.ETC_ID = I.ETC_ID
		GROUP BY H.MEDID
	) I on R.MEDID = I.MEDID
	left join(
		select PB.ddid AS drug_id, max(EVD_EXT_VOCAB_ID) as EVD_EXT_VOCAB_ID
		from prescriptions PA WITH(NOLOCK)
		INNER JOIN prescription_details PB WITH(NOLOCK) ON PA.pres_id = PB.pres_id
		inner join REVDEL0 R1 WITH(NOLOCK) on PB.ddid = R1.EVD_FDB_VOCAB_ID
		and EVD_FDB_VOCAB_TYPE_ID = 3
		AND EVD_EXT_VOCAB_TYPE_ID = 501
		where pa_id = @pa_id
		group by PB.ddid
	) qry on qry.drug_id = b.ddid
	LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON 
		B.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id
	WHERE A.PA_ID = @pa_id
	AND A.pres_approved_date is not null
	AND (A.pres_void = 0 or A.pres_void is null)
	--AND (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1)
	ORDER BY DRUG_NAME DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
