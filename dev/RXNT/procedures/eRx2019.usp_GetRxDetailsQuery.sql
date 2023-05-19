SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 2018/07/22
-- Description: Load the prescription details
-- Modified By :  
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE    PROCEDURE [eRx2019].[usp_GetRxDetailsQuery]--[eRx2019].[usp_GetRxDetailsQuery]111498968,111684523
	@RxId BIGINT,
	@RxDetailId BIGINT,
	@RelatesToMessageId VARCHAR(50)=NULL
AS  

  
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @pa_id BIGINT
	DECLARE @pres_prescription_type INT
	DECLARE @pa_phone VARCHAR(50)
	DECLARE @drug_id BIGINT
	DECLARE @plan_id VARCHAR(50)
	DECLARE @pbm_id VARCHAR(50)
	DECLARE @ic_group_numb VARCHAR(50)
	DECLARE @pa_bin VARCHAR(100)
	DECLARE @card_holder_last VARCHAR(100)
	DECLARE @card_holder_mi VARCHAR(100)
	DECLARE @card_holder_first VARCHAR(100)
	DECLARE @card_holder_id VARCHAR(100)
	DECLARE @pbm_member_id VARCHAR(100)
	DECLARE @pbm_name VARCHAR(100)
	DECLARE @is_direct_connect BIT
	DECLARE @ndc VARCHAR(50)
	DECLARE @ln25 VARCHAR(50)
	DECLARE @med_strength VARCHAR(50)
	DECLARE @med_strength_uom VARCHAR(50)
	DECLARE @med_strength_uom_code VARCHAR(50)
	DECLARE @med_ref_dea_cd VARCHAR(50)
	DECLARE @transaction_message_id VARCHAR(50)
	DECLARE @DosageFormDescription VARCHAR(50)
	DECLARE @DrugRouteDescription VARCHAR(50)
	DECLARE @RelatesToMessgaeId VARCHAR(50)
	DECLARE @IsEPCSRx BIT 
	DECLARE @PatientVitalsObservationDate DATETIME
	IF @RxId>0 AND ISNULL(@RxDetailId,0)<=0
	BEGIN
		SELECT TOP 1 @RxDetailId=pd.pd_id,@RxId=pd.pres_id
		FROM prescription_details pd WITH(NOLOCK) 
		WHERE pd.pres_id=@RxId
	END
	--IF @RelatesToMessageId IS NOT NULL AND ISNULL(@RxDetailId,0)<=0
	--BEGIN
	--	SELECT TOP 1 @RxDetailId=pd.pd_id,@RxId=pd.pres_id
	--	FROM RxNTReportUtils..rxhub_sig_transaction_log stl WITH(NOLOCK) 
	--	INNER JOIN prescription_details pd WITH(NOLOCK) ON stl.transaction_id=pd.pd_id
	--	WHERE transaction_trace_reference=@RelatesToMessageId
	--END
	 
	SELECT TOP 1 @RelatesToMessgaeId = 'NEWRX-1-'+CAST(pt_id AS VARCHAR(50)) FROM prescription_transmittals WITH(NOLOCK) WHERE PRES_ID= @RxId  ORDER BY response_date DESC
	
	SELECT TOP 1 @plan_id = PC.plan_id
	,@pbm_id = PC.pbm_id
	,@ic_group_numb = PC.[ic_group_numb]
	,@pa_bin=PC.pa_bin
	,@card_holder_last=PC.card_holder_last
	,@card_holder_mi=PC.card_holder_mi
	,@card_holder_first = PC.card_holder_first
	,@card_holder_id=PC.card_holder_id
	,@pbm_member_id = PC.[pbm_member_id]
	,@pbm_name = PC.PBM_NAME
	,@transaction_message_id=transaction_message_id
	,@is_direct_connect=is_direct_connect
	FROM (
		SELECT TOP 1 PC.transaction_message_id,PC.PD_ID,PC.ic_group_numb,PC.plan_id,PAC.pa_bin,	formularies..PBMS.PBM_NAME,formularies..PBMS.rxhub_part_id pbm_id,PAC.card_holder_last,PAC.card_holder_mi,PAC.card_holder_first,PAC.card_holder_id,PAC.pbm_member_id,ISNULL(formularies..PBMS.is_direct_connect,1) is_direct_connect
		FROM prescriptions p WITH(NOLOCK) 
		INNER JOIN prescription_details pd WITH(NOLOCK)			ON p.PRES_ID=pd.PRES_ID 
		INNER JOIN prescription_coverage_info PC WITH(NOLOCK)	ON pd.PD_ID=PC.PD_ID 
		INNER JOIN patients_coverage_info PAC WITH(NOLOCK)		ON PC.pbm_id=PAC.rxhub_pbm_id
		INNER JOIN formularies..PBMS WITH(NOLOCK)				ON PAC.rxhub_pbm_id = formularies..PBMS.rxhub_part_id 
		WHERE PC.pd_id=@RxDetailId AND PC.formulary_id = PAC.formulary_id AND p.pa_id=PAC.pa_id
		UNION
		SELECT TOP 1 '' transaction_message_id,	PC.PD_ID,PC.ic_group_numb,'' plan_id,PAC.pa_bin,formularies..PBMS.PBM_NAME,formularies..PBMS.rxhub_part_id pbm_id,PAC.card_holder_last,PAC.card_holder_mi,PAC.card_holder_first,PAC.card_holder_id,PAC.pbm_member_id ,ISNULL(formularies..PBMS.is_direct_connect,0) is_direct_connect
		FROM prescriptions p WITH(NOLOCK) 
		INNER JOIN prescription_details pd WITH(NOLOCK)				ON p.PRES_ID=pd.PRES_ID 
		INNER JOIN prescription_coverage_info PC WITH(NOLOCK)		ON pd.PD_ID=PC.PD_ID 
		INNER JOIN patients_coverage_info_external PAC WITH(NOLOCK) ON PC.pbm_id=PAC.rxhub_pbm_id
		INNER JOIN formularies..PBMS WITH(NOLOCK)					ON PAC.rxhub_pbm_id = formularies..PBMS.rxhub_part_id 
		WHERE PC.pd_id=@RxDetailId AND PC.formulary_id = PAC.formulary_id AND p.pa_id=PAC.pa_id
	) PC 
	WHERE PC.pd_id=@RxDetailId
	
	SELECT @pres_prescription_type=PRES_IN.pres_prescription_type FROM 
	PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)	
	INNER JOIN PRESCRIPTIONS PRES_IN WITH(NOLOCK) ON PDIN.pres_id=PRES_IN.pres_id 
	WHERE PDIN.PD_ID=@RxDetailId
	
	IF @pres_prescription_type=2
	BEGIN
		SELECT TOP 1  @pa_id=PRES_IN.pa_id, @drug_id=PDIN.ddid,@ndc = ISNULL(PDIN.ndc,a.NDC),@ln25 = b.MED_MEDID_DESC,@med_strength = MED_STRENGTH,@med_strength_uom=MED_STRENGTH_UOM,@med_ref_dea_cd=CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END 
		FROM rmiid1 b  WITH(NOLOCK) 
		INNER JOIN PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)			ON b.MEDID=PDIN.DDID 
		INNER JOIN PRESCRIPTIONS PRES_IN WITH(NOLOCK)			ON PDIN.pres_id=PRES_IN.pres_id 
		LEFT OUTER JOIN  rmindc1 a WITH(NOLOCK)ON a.medid=b.medid  
		WHERE PDIN.PD_ID=@RxDetailId
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT 1 FROM PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)WHERE PDIN.PD_ID=@RxDetailId AND PDIN.DDID>=1000000)
		BEGIN
			SELECT TOP 1  @pa_id=PRES_IN.pa_id, @drug_id=PDIN.ddid,@ndc = ISNULL(PDIN.ndc,RNM.NDC),@ln25 = LN25,@med_strength = MED_STRENGTH,@med_strength_uom=MED_STRENGTH_UOM,@med_ref_dea_cd=CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END 
			FROM RNMMIDNDC RNM WITH(NOLOCK) 
			INNER JOIN PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)			ON RNM.MEDID=PDIN.DDID 
			INNER JOIN PRESCRIPTIONS PRES_IN WITH(NOLOCK)			ON PDIN.pres_id=PRES_IN.pres_id 
			WHERE PDIN.PD_ID=@RxDetailId  
		END
		BEGIN
			SELECT TOP 1  @pa_id=PRES_IN.pa_id, @drug_id=PDIN.ddid,@ndc = ISNULL(PDIN.ndc,RNM.NDC),@ln25 = LN25,@med_strength = MED_STRENGTH,@med_strength_uom=MED_STRENGTH_UOM,@med_ref_dea_cd=CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END 
			FROM RNMMIDNDC RNM WITH(NOLOCK) 
			INNER JOIN PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)			ON RNM.MEDID=PDIN.DDID 
			INNER JOIN PRESCRIPTIONS PRES_IN WITH(NOLOCK)			ON PDIN.pres_id=PRES_IN.pres_id 
			WHERE PDIN.PD_ID=@RxDetailId AND RNM.OBSDTEC IS NULL
		END
	END
	
	SET @pa_phone =  [eRx2019].[ufn_GetPatientPreferredPhone](@pa_id)
		 
	 SELECT @DosageFormDescription = C.MED_DOSAGE_FORM_DESC,@DrugRouteDescription = E.MED_ROUTE_DESC 
              FROM RMIID1 A WITH(NOLOCK)
	  INNER JOIN RMIDFID1 B WITH(NOLOCK) ON A.ROUTED_DOSAGE_FORM_MED_ID = B.ROUTED_DOSAGE_FORM_MED_ID 
	  INNER JOIN RMIDFD1 C WITH(NOLOCK) ON B.MED_DOSAGE_FORM_ID = C.MED_DOSAGE_FORM_ID 
	  INNER JOIN RMIRMID1 D WITH(NOLOCK) ON B.ROUTED_MED_ID = D.ROUTED_MED_ID 
	  INNER JOIN RMIRTD1 E WITH(NOLOCK) ON D.MED_ROUTE_ID = E.MED_ROUTE_ID 
	  WHERE MEDID =@drug_id
	  
	  --IF LEN(@ndc)=0
	  --BEGIN
			--SELECT TOP 1  @ndc = RNM.NDC,@med_ref_dea_cd=CASE WHEN med_ref_dea_cd IS NULL THEN 0 ELSE med_ref_dea_cd END 
			--FROM RNMMIDNDC RNM WITH(NOLOCK)
			--INNER JOIN doc_group_freetext_med_ingredients dgfmd WITH(NOLOCK) ON RNM.MEDID=dgfmd.ingredient_drug_id 
			--INNER JOIN PRESCRIPTION_DETAILS PDIN WITH(NOLOCK)			ON dgfmd.drug_id=PDIN.DDID 
			--INNER JOIN PRESCRIPTIONS PRES_IN WITH(NOLOCK)			ON PDIN.pres_id=PRES_IN.pres_id 
			
			--WHERE PDIN.PD_ID=@RxDetailId 
			--ORDER BY dgfmd.drug_level DESC
			
	
	  --END
	  SET @med_strength_uom_code =[eRx2019].[ufn_GetDrugStrengthUnitCode](@med_strength_uom)
	  IF @pres_prescription_type=2
	  BEGIN
		
		  SELECT TOP 1  @ndc =rri.drug_ndc,@med_strength_uom_code= CASE WHEN ISNULL(@drug_id,0)=0 THEN rri.drug_strength_code ELSE @med_strength_uom_code END
		  FROM refill_requests rr WITH(NOLOCK)
		  INNER JOIN refill_requests_info rri WITH(NOLOCK) ON rr.refreq_id=rri.refreq_id
		  WHERE rr.pres_id=@RxId AND rr.pa_id=@pa_id AND rri.type='D'
	 END
	
	IF @pres_prescription_type=1 AND LEN(@ndc)>0
	BEGIN
		DECLARE @IsSpecialty BIT
		SELECT @IsSpecialty=IsSpecialty FROM [spe].[SurescriptsSpecialtyIdentificationDetails] WHERE PerformedOn>GETDATE()-1 AND NDC=@NDC
		IF @IsSpecialty IS NOT NULL
		BEGIN
				UPDATE PRESCRIPTION_DETAILS SET is_specialty=@IsSpecialty WHERE pd_id=@RxDetailId
		END
	END
	IF LEN(ISNULL(@transaction_message_id,''))<=0
	BEGIN
		SELECT TOP 1 @transaction_message_id=transaction_message_id,@is_direct_connect=1
		FROM patients_coverage_info WITH(NOLOCK)
		WHERE pa_id=@pa_id AND LEN(transaction_message_id)>0
		ORDER BY pci_id DESC
	END
	IF ISNUMERIC(@med_ref_dea_cd)=1 AND CAST(@med_ref_dea_cd AS INT)>=2
		SET @IsEPCSRx=1
		
		SELECT pd.pres_id RxId
		,pd.pd_id RxDetailId
		,dr.time_difference DoctorTimeDifference
		,dg.dc_id DoctorCompanyId
		,pd.drug_indication DrugIndication
		,p.authorizing_dr_id AuthorizingDoctorId
		,p.prim_dr_id PrimaryDoctorId
		,DATEADD(hh,-dr.time_difference,p.pres_approved_date) AS RxApprovedDate
		,pd.drug_name DrugName
		,REPLACE(REPLACE(RTRIM(LTRIM(pd.dosage +  (CASE WHEN pd.prn=1 AND p.pres_prescription_type=1 AND LEN(pd.prn_description)>0 THEN ' PRN ' + (CASE WHEN NOT(pd.prn_description IS NULL) AND p.pres_prescription_type=1 THEN pd.prn_description ELSE '' END) ELSE '' END)))+ISNULL(' MDD '+pd.max_daily_dosage+' ',''),CHAR(13),''),CHAR(10),' ') Dosage 
		,pd.use_generic UseGeneric
		,pd.numb_refills NoOfRefills
		,pd.duration_amount DrugQuantity 
		,pd.duration_unit DrugUnit
		,pd.icd9
		,pd.icd9_desc
		,pd.prn IsPRN
		,CAST(CASE WHEN p.is_signed IS NULL THEN 0 ELSE p.is_signed END AS BIT) IsSigned
		,pd.refills_prn IsRefillsPRN
		,pd.ddid DrugId
		,pd.Comments
		,CAST(pd.days_supply AS INT) DrugNoOfDaysSupply
		,dr.dg_id DoctorGroupId
		,CAST(CASE WHEN dr.epcs_enabled IS NULL THEN 0 ELSE dr.epcs_enabled END AS BIT) DoctorEPCSEnabled
		,CASE WHEN LEN(dg.dg_name) > 34 THEN SUBSTRING(dg.dg_name,0,34) ELSE dg.dg_name END DoctorGroupName
		,dr.dr_id DoctorId
		,dr.dr_first_name DoctorFirstName
		,dr.dr_last_name DoctorLastName
		,dr.dr_middle_initial DoctorMiddleName
		,dr.dr_prefix DoctorPrefix
		,dr.dr_suffix DoctorSuffix
		,dr.dr_address1 DoctorAddress1
		,dr.dr_address2 DoctorAddress2
		,dr.[dr_city] DoctorCity
		,UPPER(dr.[dr_state]) AS DoctorState
		,dr.[dr_zip] DoctorZip
		,dr.[dr_phone] DoctorPhone
		,dr.[dr_fax] DoctorFax
		,dr.dr_dea_numb DoctorDEANumber
		,dr.dr_dea_suffix DoctorDEASuffix
		,dr.dr_lic_numb DoctorLicenseNumber
		,dr.spi_id DoctorSPI
		,
		LTRIM(RTRIM(
        REPLACE(
            REPLACE(
                REPLACE(dr.npi, CHAR(9), ''),
            CHAR(13), ''),
        CHAR(10), ''))) DoctorNPI
		,dr.[dr_sig_file] DoctorSignatureFilePath
		,dr.professional_designation DoctorProfessionalDesignation
		,ph.pharm_id PharmacyId
		,ph.ncpdp_numb PharmacyNCPDPNumber
		,LTRIM(RTRIM(
        REPLACE(
            REPLACE(
                REPLACE(ph.npi, CHAR(9), ''),
            CHAR(13), ''),
        CHAR(10), ''))) PharmacyNPI
		,ph.pharm_company_name PharmacyName
		,ph.pharm_address1 PharmacyAddress1
		,ph.pharm_address2 PharmacyAddress2
		,ph.pharm_city PharmacyCity
		,UPPER(ph.pharm_state) AS PharmacyState
		,ph.pharm_zip PharmacyZip
		,ph.pharm_phone PharmacyPhone
		,ph.pharm_fax PharmacyFax
		,ph.ss_version PharmacySSVersion
		,ph.service_level PharmacyServiceLevel
		,pt.pa_id PatientId
		,pt.pa_ssn PatientSSN
		,pt.pa_ext_ssn_no PatientExternalSSN
		,pt.pa_prefix PatientPrefix
		,pt.pa_suffix PatientSuffix
		,pt.pa_first PatientFirstName
		,pt.pa_last PatientLastName
		,pt.pa_dob PatientDOB
		,pt.[pa_middle] PatientMiddleName
		,pt.[pa_address1] PatientAddress1
		,pt.[pa_address2] PatientAddress2
		,pt.[pa_city] PatientCity
		,UPPER(pt.[pa_state]) AS PatientState
		,pt.[pa_zip] PatientZip
		,pt.[pa_sex] PatientGender
		,@pa_phone PatientPhone
		,@plan_id InsurancePlanId
		,@pbm_id PBMId
		,@ic_group_numb InsuranceGrpNumb
		,@pa_bin BINNumber
		,@card_holder_last CardHolderLastName
		,@card_holder_mi CardHolderMiddleName
		,@card_holder_first CardHolderFirstName
		,@card_holder_id CardHolderId
		,CASE WHEN p.dg_id=19303 THEN pt.pa_ssn ELSE @pbm_member_id END PBMMemberId
		,@is_direct_connect IsDirectConnect
		,@pbm_name PBMName
		,@ndc NDC
		,CASE WHEN RxNCByNDC.NDCRxNormCode IS NULL THEN RxNC.RxNormCode ELSE RxNCByNDC.NDCRxNormCode END RxNormCode
		,CASE WHEN RxNCByNDC.NDCRxNormCode IS NULL THEN RxNC.RxNormCodeTypeId ELSE RxNCByNDC.NDCRxNormCodeTypeId END RxNormCodeTypeId
		,CASE WHEN RxNCByNDC.NDCRxNormCode IS NULL THEN RxNC.RxNormCodeType ELSE RxNCByNDC.NDCRxNormCodeType END RxNormCodeType
		,pd.is_specialty IsSpecialty
		,pd.rtpb_message_id RTPBMessageId
		,@ln25 ShortDrugName
		,@med_strength DrugStrength
		,@med_strength_uom DrugStrengthUOM
		,@med_strength_uom_code DrugStrengthUOMCode
		,CAST(@med_ref_dea_cd AS INT) AS DrugType
		,@transaction_message_id TransactionMessageId
		,@DosageFormDescription DosageFormDescription
		,@DrugRouteDescription DrugRouteDescription
		,@RelatesToMessgaeId RelatesToMessgaeId
		,CAST(pd.pt_height AS VARCHAR(50)) AS PatientHeight
		,CAST(pd.pt_weight AS VARCHAR(50)) AS PatientWeight
		,@PatientVitalsObservationDate AS PatientVitalsObservationDate
		,pd.coupon_id CouponId
		,pd.prior_authorization_status PriorAuthorizationStatus
		,pd.prior_auth_number PriorAuthorizationNumber
		,pd.PAReferenceId
		INTO #PrescriptionDetatils
		FROM prescriptions p WITH(NOLOCK)
		INNER JOIN prescription_details pd WITH(NOLOCK) ON p.PRES_ID = pd.PRES_ID 
		INNER JOIN patients pt WITH(NOLOCK) ON p.pa_id = pt.pa_id
		INNER JOIN doctors dr WITH(NOLOCK) ON p.dr_id = dr.dr_id
		INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.DG_ID = dg.DG_ID
		INNER JOIN pharmacies ph WITH(NOLOCK) ON p.pharm_id = ph.pharm_id
		INNER JOIN eRx2019.ufn_GetRxNormCode(@drug_id) RxNC  ON RxNC.DrugId=pd.ddid
		LEFT OUTER JOIN eRx2019.ufn_GetRxNormCodeByNDC(@ndc) RxNCByNDC  ON RxNCByNDC.NDC=@ndc
		WHERE p.PRES_ID=@RxId
		
		
		
		IF @IsEPCSRx=1 AND EXISTS(SELECT TOP 1 * FROM scheduled_rx_archive SRA WITH(NOLOCK) WHERE sra.PRES_ID=@RxId  AND sra.pd_id=@RxDetailId)
		BEGIN
		
		--Final

		
		SELECT pd.RxId
		,pd.RxDetailId
		,pd.DoctorCompanyId
		,pd.AuthorizingDoctorId
		,pd.PrimaryDoctorId
		,DATEADD(hh,-pd.DoctorTimeDifference,sra.approved_date) AS RxApprovedDate
		,sra.drug_name AS DrugName
		,pd.Dosage 
		,pd.UseGeneric
		,sra.refills AS NoOfRefills
		,sra.qty AS DrugQuantity
		,sra.units AS DrugUnit
		,pd.IsPRN
		,CAST(pd.IsSigned AS BIT) IsSigned
		,pd.IsRefillsPRN
		,sra.ddid DrugId
		,pd.Comments
		,CAST(sra.days_supply AS INT) DrugNoOfDaysSupply
		,sra.dg_id DoctorGroupId
		,CAST(pd.DoctorEPCSEnabled AS BIT) DoctorEPCSEnabled
		,pd.DoctorGroupName
		,sra.dr_id DoctorId
		,sra.dr_first_name DoctorFirstName
		,sra.dr_last_name DoctorLastName
		,sra.dr_middle_initial DoctorMiddleName
		,pd.DoctorPrefix
		,pd.DoctorSuffix
		,sra.dr_address1 DoctorAddress1
		,sra.dr_address2 DoctorAddress2
		,sra.[dr_city] DoctorCity
		,UPPER(sra.[dr_state]) AS DoctorState
		,sra.[dr_zip] DoctorZip
		,pd.DoctorPhone
		,pd.DoctorFax
		,sra.DR_DEA_NUMB DoctorDEANumber
		,pd.DoctorDEASuffix
		,pd.DoctorLicenseNumber
		,pd.DoctorSPI
		,pd.DoctorNPI
		,pd.DoctorSignatureFilePath
		,pd.DoctorProfessionalDesignation
		,pd.PharmacyId
		,pd.PharmacyNCPDPNumber
		,pd.PharmacyNPI
		,pd.PharmacyName
		,pd.PharmacyAddress1
		,pd.PharmacyAddress2
		,pd.PharmacyCity
		,pd.PharmacyState
		,pd.PharmacyZip
		,pd.PharmacyPhone
		,pd.PharmacyFax
		,pd.PharmacySSVersion
		,pd.PharmacyServiceLevel
		,sra.pa_id PatientId
		,pd.PatientSSN
		,pd.PatientExternalSSN
		,pd.PatientPrefix
		,pd.PatientSuffix
		,sra.PA_FIRST PatientFirstName
		,sra.PA_LAST PatientLastName
		,sra.PA_DOB PatientDOB
		,sra.[pa_middle] PatientMiddleName
		,sra.[pa_address1] PatientAddress1
		,sra.[pa_address2] PatientAddress2
		,sra.[pa_city] PatientCity
		,UPPER(sra.[pa_state]) AS PatientState
		,sra.[pa_zip] PatientZip
		,sra.pa_gender AS PatientGender
		,@pa_phone PatientPhone
		,pd.InsurancePlanId
		,pd.PBMId
		,pd.InsuranceGrpNumb
		,pd.BINNumber
		,pd.CardHolderLastName
		,pd.CardHolderMiddleName
		,pd.CardHolderFirstName
		,pd.CardHolderId
		,pd.PBMMemberId
		,pd.IsDirectConnect
		,pd.PBMName
		,pd.NDC
		,pd.RxNormCode
		,pd.RxNormCodeTypeId
		,pd.RxNormCodeType
		,pd.IsSpecialty
		,pd.RTPBMessageId
		,pd.ShortDrugName
		,pd.DrugStrength
		,pd.DrugStrengthUOM
		,pd.DrugStrengthUOMCode
		,pd.DosageFormDescription
		,pd.DrugRouteDescription
		,CAST(pd.DrugType AS INT) DrugType
		,pd.TransactionMessageId
		,sra.Signature
		,CASE WHEN du.potency_unit_code IS NULL THEN 'C38046' ELSE du.potency_unit_code END PotencyUnitCode  
		,CASE WHEN NOT(DGI.icd10 IS NULL) AND pd.DoctorGroupId=28131 THEN DGI.icd10 ELSE pd.icd9 END DiagnosisCode
		,CASE WHEN NOT(DGI.icd10 IS NULL) AND pd.DoctorGroupId=28131 THEN DGI.description ELSE pd.icd9_desc END DiagnosisDescription
		,dgfm.drug_category DrugCategory
		,pd.RelatesToMessgaeId
		,CAST(pd.PatientHeight AS VARCHAR(50)) PatientHeight
		,CAST(pd.PatientWeight AS VARCHAR(50)) PatientWeight
		,pd.PatientVitalsObservationDate
		,cpn.coupon_id CouponId
		,cpn.rx_payer_id CouponPayerID
		,cpn.rx_pcn CouponProcessorIdentificationNumber 
		,cpn.rx_bin CouponIINNumber
		,cpn.rx_payer_name CouponPayerName 
		,cpn.rx_grp CouponGroupID
		,cpn.rx_payer_type CouponPayerType
		,pd.PriorAuthorizationStatus
		,pd.PriorAuthorizationNumber
		,pd.PAReferenceId
		FROM #PrescriptionDetatils pd WITH(NOLOCK)
		INNER JOIN scheduled_rx_archive SRA WITH(NOLOCK) ON pd.RxId = sra.PRES_ID  AND pd.RxDetailId = sra.pd_id
		
		LEFT OUTER JOIN doc_group_freetext_meds dgfm WITH(NOLOCK)ON pd.DrugId=dgfm.drug_id
		LEFT OUTER JOIN doc_groups DG_FTM WITH(NOLOCK) ON pd.DoctorCompanyId = DG_FTM.DC_ID AND dgfm.dg_id = DG_FTM.dg_id
		LEFT OUTER JOIN duration_units DU WITH(NOLOCK) ON sra.units = DU.du_text
		LEFT OUTER JOIN doc_group_drug_indication DGI with(nolock) on pd.DoctorGroupId = DGI.dg_id and pd.DrugIndication = DGI.description
		LEFT OUTER JOIN rxnt_coupons cpn WITH(NOLOCK) ON cpn.coupon_id=pd.CouponId AND  cpn.med_id=pd.DrugId
		WHERE pd.RxId=@RxId
		
	END
	ELSE
	BEGIN
		SELECT pd.RxId
		,pd.RxDetailId
		,pd.DoctorCompanyId
		,pd.AuthorizingDoctorId
		,pd.PrimaryDoctorId
		,pd.RxApprovedDate
		,pd.DrugName
		,pd.Dosage 
		,pd.UseGeneric
		,pd.NoOfRefills
		,pd.DrugQuantity
		,pd.DrugUnit
		,pd.IsPRN
		,CAST(pd.IsSigned AS BIT) IsSigned
		,pd.IsRefillsPRN
		,pd.DrugId
		,pd.Comments
		,pd.DrugNoOfDaysSupply
		,pd.DoctorGroupId
		,CAST(pd.DoctorEPCSEnabled AS BIT) DoctorEPCSEnabled
		,pd.DoctorGroupName
		,pd.DoctorId
		,pd.DoctorFirstName
		,pd.DoctorLastName
		,pd.DoctorMiddleName
		,pd.DoctorPrefix
		,pd.DoctorSuffix
		,pd.DoctorAddress1
		,pd.DoctorAddress2
		,pd.DoctorCity
		,pd.DoctorState
		,pd.DoctorZip
		,pd.DoctorPhone
		,pd.DoctorFax
		,pd.DoctorDEANumber
		,pd.DoctorDEASuffix
		,pd.DoctorLicenseNumber
		,pd.DoctorSPI
		,pd.DoctorNPI
		,pd.DoctorSignatureFilePath
		,pd.DoctorProfessionalDesignation
		,pd.PharmacyId
		,pd.PharmacyNCPDPNumber
		,pd.PharmacyNPI
		,pd.PharmacyName
		,pd.PharmacyAddress1
		,pd.PharmacyAddress2
		,pd.PharmacyCity
		,pd.PharmacyState
		,pd.PharmacyZip
		,pd.PharmacyPhone
		,pd.PharmacyFax
		,pd.PharmacySSVersion
		,pd.PharmacyServiceLevel
		,pd.PatientId
		,pd.PatientSSN
		,pd.PatientExternalSSN
		,pd.PatientPrefix
		,pd.PatientSuffix
		,pd.PatientFirstName
		,pd.PatientLastName
		,pd.PatientDOB
		,pd.PatientMiddleName
		,pd.PatientAddress1
		,pd.PatientAddress2
		,pd.PatientCity
		,pd.PatientState
		,pd.PatientZip
		,pd.PatientGender
		,@pa_phone PatientPhone
		,pd.InsurancePlanId
		,pd.PBMId
		,pd.InsuranceGrpNumb
		,pd.BINNumber
		,pd.CardHolderLastName
		,pd.CardHolderMiddleName
		,pd.CardHolderFirstName
		,pd.CardHolderId
		,pd.PBMMemberId
		,pd.IsDirectConnect
		,pd.PBMName
		,pd.NDC
		,pd.RxNormCode
		,pd.RxNormCodeTypeId
		,pd.RxNormCodeType
		,pd.IsSpecialty
		,pd.RTPBMessageId
		,pd.ShortDrugName
		,pd.DrugStrength
		,pd.DrugStrengthUOM
		,pd.DrugStrengthUOMCode
		,pd.DosageFormDescription
		,pd.DrugRouteDescription
		,CAST(pd.DrugType AS INT) DrugType
		,pd.TransactionMessageId
		,NULL Signature
		,CASE WHEN du.potency_unit_code IS NULL THEN 'C38046' ELSE du.potency_unit_code END PotencyUnitCode  
		,CASE WHEN NOT(DGI.icd10 IS NULL) AND pd.DoctorGroupId=28131 THEN DGI.icd10 ELSE pd.icd9 END DiagnosisCode
		,CASE WHEN NOT(DGI.icd10 IS NULL) AND pd.DoctorGroupId=28131 THEN DGI.description ELSE pd.icd9_desc END DiagnosisDescription
		,dgfm.drug_category DrugCategory
		,pd.RelatesToMessgaeId
		,CAST(pd.PatientHeight AS VARCHAR(50)) PatientHeight
		,CAST(pd.PatientWeight AS VARCHAR(50)) PatientWeight
		,pd.PatientVitalsObservationDate
		,cpn.coupon_id CouponId
		,cpn.rx_payer_id CouponPayerID
		,cpn.rx_pcn CouponProcessorIdentificationNumber 
		,cpn.rx_bin CouponIINNumber
		,cpn.rx_payer_name CouponPayerName 
		,cpn.rx_grp CouponGroupID
		,cpn.rx_payer_type CouponPayerType
		,pd.PriorAuthorizationStatus
		,pd.PriorAuthorizationNumber
		,pd.PAReferenceId
		FROM #PrescriptionDetatils  pd WITH(NOLOCK)
		LEFT OUTER JOIN doc_group_freetext_meds dgfm WITH(NOLOCK)	ON pd.DrugId=dgfm.drug_id
		LEFT OUTER JOIN doc_groups DG_FTM WITH(NOLOCK)				ON pd.DoctorCompanyId = DG_FTM.DC_ID AND dgfm.dg_id = DG_FTM.dg_id
		LEFT OUTER JOIN duration_units DU WITH(NOLOCK)				ON pd.DrugUnit = DU.du_text
		LEFT OUTER JOIN doc_group_drug_indication DGI WITH(NOLOCK)	ON pd.DoctorGroupId = DGI.dg_id and pd.DrugIndication = DGI.description
		LEFT OUTER JOIN rxnt_coupons cpn WITH(NOLOCK) ON cpn.coupon_id=pd.CouponId AND  cpn.med_id=pd.DrugId

	END		 
	
	DROP TABLE #PrescriptionDetatils
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
