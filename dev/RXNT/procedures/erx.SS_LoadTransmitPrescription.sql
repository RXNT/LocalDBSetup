SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Nambi  
-- ALTER  date: 08/16/2017
-- Description: Load the transmit prescription  
-- Modified By : Vijay D
-- Modified Date: 01/30/2018
-- Modified Description:  Added PRN Description not empty condition to add PRN Value
-- =============================================  
CREATE  PROCEDURE [erx].[SS_LoadTransmitPrescription]
 @presid int,  
 @pdid int  
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT P.authorizing_dr_id,P.prim_dr_id,DATEADD(hh,-DR.TIME_DIFFERENCE,P.PRES_APPROVED_DATE) AS PRES_APPROVED_DATE,PD.DRUG_NAME, 
		Replace(REPLACE(RTRIM(LTRIM(PD.DOSAGE +  (CASE WHEN PD.PRN=1 AND P.pres_prescription_type=1 AND LEN(PD.PRN_DESCRIPTION)>0 THEN ' PRN ' + (CASE WHEN NOT(PD.PRN_DESCRIPTION IS NULL) AND P.pres_prescription_type=1 THEN PD.PRN_DESCRIPTION ELSE '' END) ELSE '' END)))+ISNULL(' MDD '+PD.max_daily_dosage+' ',''),CHAR(13),''),CHAR(10),' ') DOSAGE , PD.USE_GENERIC, 
		PD.NUMB_REFILLS, PD.DURATION_AMOUNT, 
		PD.DURATION_UNIT, PD.icd9,
		case when du.potency_unit_code is null then 'C38046' else du.potency_unit_code end potency_unit_code  , 
		PD.PRN,case when P.is_signed is null then 0 ELSE P.is_signed END is_signed,PD.refills_prn,
		dgfm.drug_category,
		PD.DDID, PD.COMMENTS,PD.days_supply,DR.DG_ID,CASE WHEN epcs_enabled is null then 0 ELSE epcs_enabled END EPCS,
		CASE WHEN LEN(DG.DG_NAME) > 34 THEN SUBSTRING(DG.dg_name,0,34) ELSE DG.dg_name END DG_NAME,
		DR.DR_ID,DR.DR_FIRST_NAME, DR.DR_LAST_NAME,DR.dr_middle_initial, DR.dr_prefix,DR.dr_suffix, DR.dr_address1,DR.dr_address2,DR.[dr_city],
		UPPER(DR.[dr_state]) AS dr_state,DR.[dr_zip],
		DR.[dr_phone],DR.DR_DEA_NUMB,DR.DR_LAST_NAME,DR.DR_LIC_NUMB,DR.SPI_ID,DR.NPI,DR.[dr_sig_file],DR.professional_designation,PH.PHARM_ID,
		PH.NCPDP_NUMB,PH.NPI AS pharm_npi,PH.PHARM_COMPANY_NAME, PH.PHARM_ADDRESS1, PH.PHARM_ADDRESS2, PH.PHARM_CITY, 
		UPPER(PH.PHARM_STATE) AS PHARM_STATE, PH.PHARM_ZIP, PH.PHARM_PHONE, PH.PHARM_FAX,PH.SS_VERSION,PT.pa_id,PT.pa_ssn,PT.pa_ext_ssn_no,
		PT.pa_prefix,PT.pa_suffix,PT.PA_FIRST, PT.PA_LAST,PT.PA_DOB,PT.[pa_middle],PT.[pa_address1],PT.[pa_address2],PT.[pa_city],UPPER(PT.[pa_state]) AS pa_state,PT.[pa_zip],
		PT.[pa_sex],PT.[pa_phone],PC.plan_id,
		PC.pbm_id,PC.[ic_group_numb],PC.pa_bin,PC.pbm_id,PC.card_holder_last,PC.card_holder_mi,PC.card_holder_first,PC.card_holder_id,
		case when P.dg_id=19303 Then PT.pa_ssn else PC.[pbm_member_id] end [pbm_member_id],PC.PBM_NAME,
		RM.NDC,RM.LN25,RM.MED_STRENGTH,RM.MED_STRENGTH_UOM, 
		case WHEN RM.MED_REF_DEA_CD is null then 0 ELSE RM.MED_REF_DEA_CD END MED_REF_DEA_CD,transaction_message_id
		FROM PRESCRIPTIONS P WITH(NOLOCK)
		INNER JOIN PRESCRIPTION_DETAILS PD WITH(NOLOCK) ON P.PRES_ID = PD.PRES_ID 
		INNER JOIN PATIENTS PT WITH(NOLOCK) ON P.PA_ID = PT.PA_ID
		INNER JOIN DOCTORS DR WITH(NOLOCK) ON P.DR_ID = DR.DR_ID
		INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON DR.DG_ID = DG.DG_ID
		LEFT OUTER JOIN doc_group_freetext_meds dgfm WITH(NOLOCK) ON PD.DDID=dgfm.drug_id 
		LEFT OUTER JOIN DOC_GROUPS DG_FTM WITH(NOLOCK) ON DG.DC_ID = DG_FTM.DC_ID AND dgfm.dg_id = DG_FTM.dg_id
		LEFT OUTER JOIN duration_units DU WITH(NOLOCK) ON pd.duration_unit = DU.du_text 
		INNER JOIN PHARMACIES PH WITH(NOLOCK) ON P.PHARM_ID = PH.PHARM_ID
		LEFT OUTER JOIN (select top 1 PC.transaction_message_id,PC.PD_ID,PC.ic_group_numb,PC.plan_id,PAC.pa_bin,formularies..PBMS.PBM_NAME,formularies..PBMS.rxhub_part_id pbm_id,PAC.card_holder_last,
		PAC.card_holder_mi,PAC.card_holder_first,PAC.card_holder_id,PAC.pbm_member_id from prescriptions P WITH(NOLOCK) 
		inner join prescription_details PD WITH(NOLOCK) ON P.PRES_ID=PD.PRES_ID INNER JOIN 
		prescription_coverage_info PC WITH(NOLOCK) ON PD.PD_ID=PC.PD_ID INNER JOIN patients_coverage_info PAC on PC.pbm_id=PAC.rxhub_pbm_id
		inner join formularies..PBMS on PAC.rxhub_pbm_id = formularies..PBMS.rxhub_part_id 
		 where PC.pd_id=@PDID AND PC.formulary_id = PAC.formulary_id AND P.pa_id=PAC.pa_id) PC ON PD.PD_ID=PC.PD_ID
		LEFT OUTER JOIN (SELECT TOP 1 MEDID,RNM.NDC,LN25,MED_STRENGTH,MED_STRENGTH_UOM,MED_REF_DEA_CD 
		FROM RNMMIDNDC RNM WITH(NOLOCK) INNER JOIN PRESCRIPTION_DETAILS PDIN WITH(NOLOCK) ON RNM.MEDID=PDIN.DDID 
		WHERE PDIN.PD_ID=@PDID)	RM ON PD.DDID=RM.MEDID
		WHERE P.PRES_ID=@PRESID
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
