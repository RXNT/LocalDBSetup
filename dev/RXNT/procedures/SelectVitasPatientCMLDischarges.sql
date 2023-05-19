SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Stored Procedure

/*
=======================================================================================
Author	:	Rasheed
Create date	:	18-November-2016
Description	:	Fetch the patient CML discharges
Last Modified By	:	Prabhash H
Last Modifed Date	:	13-October-2017
=======================================================================================
*/

CREATE PROCEDURE [dbo].[SelectVitasPatientCMLDischarges]
@pa_id int
AS
BEGIN

SELECT DISTINCT 
A.pres_id PAM_ID, B.ddid AS DRUG_ID, R.MED_REF_DEA_CD drug_class,
CASE WHEN B.ddid <= -1 THEN B.drug_name ELSE R.MED_MEDID_DESC END DRUG_NAME, 
0 ETC_ID, '' ETC_NAME, 
A.pres_entry_date DATE_ADDED, COMPOUND, COMMENTS, B.pd_id pd_id, NULL AS record_source,
DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE,B.dosage, duration_amount, 
duration_unit, B.comments AS drug_comments, numb_refills, use_generic, 
days_supply, prn, B.drug_indication prn_description, A.pres_approved_date AS date_start, NULL AS date_end, 
0 as RxNormCode, AD.MEDID ACTIVEDDID,
hdr.hospice_drug_relatedness_id,hdr.Code,hdr.Description,
vwGCN.GCN_SEQNO GCN_SEQNO, 
B.discharge_date, A.dr_id
FROM 
prescriptions A WITH(NOLOCK)	
INNER JOIN prescription_details B WITH(NOLOCK) ON A.pres_id = B.pres_id
INNER JOIN prescription_discharge_external_info PDEI with(nolock) on A.pres_id = PDEI.pres_id
INNER JOIN DOCTORS DR ON A.dr_id = DR.DR_ID
LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON	B.ddid = R.MEDID 
LEFT OUTER JOIN vwMedGCN vwGCN WITH(NOLOCK) ON R.MEDID = vwGCN.MEDID
LEFT OUTER JOIN ACTIVE_DRUGS AD ON R.MEDID = AD.MEDID
LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON B.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id
WHERE A.PA_ID = @pa_id
AND A.PRES_APPROVED_DATE IS NOT NULL
AND (A.pres_void = 0 or A.pres_void is null)
AND B.history_enabled = 0
AND (PDEI.batch_id IS NULL or PDEI.response_status = 'Failed' Or PDEI.external_source_syncdate IS NULL)
ORDER BY DRUG_NAME DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
