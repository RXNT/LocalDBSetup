SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Thomas
-- ALTER  date: 2007/06/19
-- Description:	Load the transmit prescription
-- =============================================
CREATE  PROCEDURE [dbo].[LoadTransmitPrescription]
	@presid int,
	@pdid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT P.authorizing_dr_id,P.prim_dr_id,P.PRES_APPROVED_DATE,PD.DRUG_NAME, PD.DOSAGE, PD.USE_GENERIC, 
		PD.NUMB_REFILLS, PD.DURATION_AMOUNT, PD.DURATION_UNIT, PD.PRN,case when P.is_signed is null then 0 ELSE P.is_signed END is_signed,PD.refills_prn,
		PD.DDID, PD.COMMENTS,PD.days_supply,DR.DG_ID,CASE WHEN epcs_enabled is null then 0 ELSE epcs_enabled END EPCS,
		DR.DR_ID,DR.DR_FIRST_NAME, DR.DR_LAST_NAME,DR.dr_middle_initial, DR.dr_prefix,DR.dr_suffix, DR.dr_address1,DR.dr_address2,DR.[dr_city],DR.[dr_state],DR.[dr_zip],
		DR.[dr_phone],DR.DR_DEA_NUMB,DR.DR_LAST_NAME,DR.DR_LIC_NUMB,DR.SPI_ID,DR.NPI,DR.[dr_sig_file],DR.professional_designation,PH.PHARM_ID,
		PH.NCPDP_NUMB,PH.PHARM_COMPANY_NAME, PH.PHARM_ADDRESS1, PH.PHARM_ADDRESS2, PH.PHARM_CITY, 
		PH.PHARM_STATE, PH.PHARM_ZIP, PH.PHARM_PHONE, PH.PHARM_FAX,PH.SS_VERSION,PT.pa_id,PT.pa_ssn,
		PT.PA_FIRST, PT.PA_LAST,PT.PA_DOB,PT.[pa_middle],PT.[pa_address1],PT.[pa_address2],PT.[pa_city],PT.[pa_state],PT.[pa_zip],
		PT.[pa_sex],PT.[pa_phone],PC.plan_id,
		PC.pbm_id,PC.[ic_group_numb],PC.pa_bin,PC.pbm_id,PC.card_holder_last,PC.card_holder_mi,PC.card_holder_first,PC.card_holder_id,
		case when P.dg_id=19303 Then PT.pa_ssn else PC.[pbm_member_id] end [pbm_member_id],PC.PBM_NAME,
		RM.NDC,RM.LN25,RM.MED_STRENGTH,RM.MED_STRENGTH_UOM, case WHEN RM.MED_REF_DEA_CD is null then 0 ELSE RM.MED_REF_DEA_CD END MED_REF_DEA_CD
		FROM PRESCRIPTIONS P 
		INNER JOIN PRESCRIPTION_DETAILS PD ON P.PRES_ID = PD.PRES_ID 
		INNER JOIN PATIENTS PT ON P.PA_ID = PT.PA_ID
		INNER JOIN DOCTORS DR WITH(NOLOCK) ON P.DR_ID = DR.DR_ID 
		INNER JOIN PHARMACIES PH WITH(NOLOCK) ON P.PHARM_ID = PH.PHARM_ID
		LEFT OUTER JOIN (select top 1 PC.PD_ID,PC.ic_group_numb,PC.plan_id,PAC.pa_bin,formularies..PBMS.PBM_NAME,formularies..PBMS.rxhub_part_id pbm_id,PAC.card_holder_last,
		PAC.card_holder_mi,PAC.card_holder_first,PAC.card_holder_id,PAC.pbm_member_id from prescriptions P WITH(NOLOCK) 
		inner join prescription_details PD WITH(NOLOCK) ON P.PRES_ID=PD.PRES_ID INNER JOIN 
		prescription_coverage_info PC WITH(NOLOCK) ON PD.PD_ID=PC.PD_ID INNER JOIN patients_coverage_info PAC on PC.pbm_id=PAC.rxhub_pbm_id
		inner join formularies..PBMS on PAC.rxhub_pbm_id = formularies..PBMS.rxhub_part_id 
		 where PC.pd_id=@PDID AND PC.formulary_id = PAC.formulary_id AND P.pa_id=PAC.pa_id) PC ON PD.PD_ID=PC.PD_ID
		LEFT OUTER JOIN (SELECT TOP 1 MEDID,RNM.NDC,LN25,MED_STRENGTH,MED_STRENGTH_UOM,MED_REF_DEA_CD 
		FROM RNMMIDNDC RNM WITH(NOLOCK) INNER JOIN PRESCRIPTION_DETAILS PDIN ON RNM.MEDID=PDIN.DDID 
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
