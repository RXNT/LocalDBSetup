SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 2015/07/22
-- Description: Load the transmit epcs prescription  
-- Modified By : Vijay D
-- Modified Date: 01/30/2018
-- Modified Description:  Added PRN Description not empty condition to add PRN Value
-- =============================================  
CREATE  PROCEDURE [dbo].[SS_LoadTransmitEPCSPrescription_Test]

 @presid int,  
 @pdid int  
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		DECLARE @plan_id VARCHAR(50)
		DECLARE @pbm_id VARCHAR(50)
		DECLARE @ic_group_numb VARCHAR(50)
		DECLARE @pa_bin VARCHAR(100)
		DECLARE @card_holder_last VARCHAR(100)
		DECLARE @card_holder_mi VARCHAR(100)
		DECLARE @card_holder_first VARCHAR(100)
		DECLARE @card_holder_id VARCHAR(100)
		DECLARE @pbm_member_id VARCHAR(100)
		DECLARE @PBM_NAME VARCHAR(100)
		DECLARE @NDC VARCHAR(50)
		DECLARE @LN25 VARCHAR(50)
		DECLARE @MED_STRENGTH VARCHAR(50)
		DECLARE @MED_STRENGTH_UOM VARCHAR(50)
		DECLARE @MED_REF_DEA_CD VARCHAR(50)
		DECLARE @transaction_message_id VARCHAR(50)
		SELECT 
		@plan_id = PC.plan_id,
		@pbm_id = PC.pbm_id,@ic_group_numb = PC.[ic_group_numb],@pa_bin=PC.pa_bin,@card_holder_last=PC.card_holder_last,@card_holder_mi=PC.card_holder_mi,@card_holder_first = PC.card_holder_first,@card_holder_id=PC.card_holder_id,
		@pbm_member_id = PC.[pbm_member_id],@PBM_NAME = PC.PBM_NAME,
		@transaction_message_id=transaction_message_id
		 FROM (
		select top 1 
			PC.transaction_message_id,PC.PD_ID,PC.ic_group_numb,PC.plan_id,
			PAC.pa_bin,formularies..PBMS.PBM_NAME,formularies..PBMS.rxhub_part_id pbm_id,PAC.card_holder_last,
			PAC.card_holder_mi,PAC.card_holder_first,PAC.card_holder_id,PAC.pbm_member_id 
		from prescriptions P WITH(NOLOCK) 
			inner join prescription_details PD WITH(NOLOCK) ON P.PRES_ID=PD.PRES_ID 
			INNER JOIN 
			prescription_coverage_info PC WITH(NOLOCK) ON PD.PD_ID=PC.PD_ID 
			INNER JOIN patients_coverage_info PAC on PC.pbm_id=PAC.rxhub_pbm_id
			inner join formularies..PBMS on PAC.rxhub_pbm_id = formularies..PBMS.rxhub_part_id 
			where PC.pd_id=@PDID AND PC.formulary_id = PAC.formulary_id AND P.pa_id=PAC.pa_id
		 UNION
		 select top 1 '' transaction_message_id,
			PC.PD_ID,PC.ic_group_numb,'' plan_id,PAC.pa_bin,
			formularies..PBMS.PBM_NAME,formularies..PBMS.rxhub_part_id pbm_id,PAC.card_holder_last,
				PAC.card_holder_mi,PAC.card_holder_first,PAC.card_holder_id,PAC.pbm_member_id 
				from prescriptions P WITH(NOLOCK) 
				inner join prescription_details PD WITH(NOLOCK) ON P.PRES_ID=PD.PRES_ID 
				INNER JOIN prescription_coverage_info PC WITH(NOLOCK) ON PD.PD_ID=PC.PD_ID 
				INNER JOIN patients_coverage_info_external PAC WITH(NOLOCK) on PC.pbm_id=PAC.rxhub_pbm_id
				inner join formularies..PBMS WITH(NOLOCK) 
					on PAC.rxhub_pbm_id = formularies..PBMS.rxhub_part_id 
				 where PC.pd_id=@PDID AND PC.formulary_id = PAC.formulary_id AND P.pa_id=PAC.pa_id
		 ) PC 
		 WHERE PC.pd_id=@pdid
		
		SELECT TOP 1  @NDC = RNM.NDC,@LN25 = LN25,@MED_STRENGTH = MED_STRENGTH,@MED_STRENGTH_UOM=MED_STRENGTH_UOM,@MED_REF_DEA_CD=case WHEN MED_REF_DEA_CD is null then 0 ELSE MED_REF_DEA_CD END 
		FROM RNMMIDNDC RNM WITH(NOLOCK) INNER JOIN PRESCRIPTION_DETAILS PDIN ON RNM.MEDID=PDIN.DDID 
		WHERE PDIN.PD_ID=@PDID
		
		SELECT P.authorizing_dr_id,P.prim_dr_id,DATEADD(hh,-DR.TIME_DIFFERENCE,SRA.APPROVED_DATE) AS PRES_APPROVED_DATE,SRA.DRUG_NAME, 
		Replace(REPLACE(RTRIM(LTRIM(PD.DOSAGE +  (CASE WHEN PD.PRN=1 AND P.pres_prescription_type=1 AND LEN(PD.PRN_DESCRIPTION)>0 THEN ' PRN ' + (CASE WHEN NOT(PD.PRN_DESCRIPTION IS NULL) AND P.pres_prescription_type=1 THEN PD.PRN_DESCRIPTION ELSE '' END) ELSE '' END)))+ISNULL(' MDD '+PD.max_daily_dosage+' ',''),CHAR(13),''),CHAR(10),' ') DOSAGE , PD.USE_GENERIC, 
		SRA.refills AS NUMB_REFILLS, SRA.qty AS DURATION_AMOUNT, SRA.units AS DURATION_UNIT, 
		case when NOT(DGI.icd10 is null) and P.dg_id=28131 THEN DGI.icd10 else PD.icd9 end icd9,
		case when du.potency_unit_code is null then 'C38046' else du.potency_unit_code end potency_unit_code  , 
		PD.PRN,case when P.is_signed is null then 0 ELSE P.is_signed END is_signed,PD.refills_prn,
		dgfm.drug_category,
		SRA.DDID, PD.COMMENTS,SRA.days_supply,SRA.DG_ID,CASE WHEN epcs_enabled is null then 0 ELSE epcs_enabled END EPCS,
		CASE WHEN LEN(DG.DG_NAME) > 34 THEN SUBSTRING(DG.dg_name,0,34) ELSE DG.dg_name END DG_NAME,
		SRA.DR_ID,SRA.DR_FIRST_NAME, SRA.DR_LAST_NAME,SRA.dr_middle_initial, DR.dr_prefix,DR.dr_suffix, SRA.dr_address1,SRA.dr_address2,SRA.[dr_city],
		UPPER(SRA.[dr_state]) AS dr_state,SRA.[dr_zip],
		DR.[dr_phone],SRA.DR_DEA_NUMB,SRA.DR_LAST_NAME,DR.DR_LIC_NUMB,DR.SPI_ID,DR.NPI,DR.[dr_sig_file],DR.professional_designation,PH.PHARM_ID,
		PH.NCPDP_NUMB,PH.NPI AS pharm_npi,PH.PHARM_COMPANY_NAME, PH.PHARM_ADDRESS1, PH.PHARM_ADDRESS2, PH.PHARM_CITY, 
		UPPER(PH.PHARM_STATE) AS PHARM_STATE, PH.PHARM_ZIP, PH.PHARM_PHONE, PH.PHARM_FAX,PH.SS_VERSION,SRA.pa_id,PT.pa_ssn,PT.pa_ext_ssn_no,
		PT.pa_prefix,PT.pa_suffix,SRA.PA_FIRST, SRA.PA_LAST,SRA.PA_DOB,SRA.[pa_middle],SRA.[pa_address1],SRA.[pa_address2],SRA.[pa_city],UPPER(SRA.[pa_state]) AS pa_state,SRA.[pa_zip],
		SRA.pa_gender AS pa_sex,PT.[pa_phone],@plan_id plan_id,
		@pbm_id pbm_id,@ic_group_numb [ic_group_numb],@pa_bin pa_bin,@card_holder_last card_holder_last,@card_holder_mi card_holder_mi,@card_holder_first card_holder_first,@card_holder_id card_holder_id,
		case when P.dg_id=19303 Then PT.pa_ssn else @pbm_member_id end [pbm_member_id],@PBM_NAME PBM_NAME,
		@NDC NDC,@LN25 LN25,@MED_STRENGTH MED_STRENGTH,@MED_STRENGTH_UOM MED_STRENGTH_UOM, 
		@MED_REF_DEA_CD MED_REF_DEA_CD,
		'' transaction_message_id,
		SRA.signature
		FROM PRESCRIPTIONS P WITH(NOLOCK)
		INNER JOIN PRESCRIPTION_DETAILS PD WITH(NOLOCK) ON P.PRES_ID = PD.PRES_ID 
		INNER JOIN scheduled_rx_archive SRA WITH(NOLOCK) ON P.PRES_ID = SRA.PRES_ID  AND PD.pd_id = SRA.pd_id
		INNER JOIN PATIENTS PT WITH(NOLOCK) ON P.PA_ID = PT.PA_ID
		INNER JOIN DOCTORS DR WITH(NOLOCK) ON P.DR_ID = DR.DR_ID
		INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON DR.DG_ID = DG.DG_ID
		LEFT OUTER JOIN doc_group_freetext_meds dgfm WITH(NOLOCK)ON PD.DDID=dgfm.drug_id
		LEFT OUTER JOIN DOC_GROUPS DG_FTM WITH(NOLOCK) ON DG.DC_ID = DG_FTM.DC_ID AND dgfm.dg_id = DG_FTM.dg_id
		LEFT OUTER JOIN duration_units DU WITH(NOLOCK) ON SRA.units = DU.du_text
		LEFT OUTER JOIN doc_group_drug_indication DGI with(nolock) on P.dg_id = DGI.dg_id and PD.drug_indication = DGI.description
		INNER JOIN PHARMACIES PH WITH(NOLOCK) ON P.PHARM_ID = PH.PHARM_ID
		
		WHERE P.PRES_ID=@PRESID
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
