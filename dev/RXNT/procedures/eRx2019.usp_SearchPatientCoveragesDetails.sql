SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: Feb 20, 2020
-- Description:	Load patient coverage information
-- =============================================
CREATE PROCEDURE [eRx2019].[usp_SearchPatientCoveragesDetails]
(
	-- Add the parameters for the stored procedure here
	@PatientId	INT,
	@DoctorCompanyId BIGINT,
	@HasNoFormulary BIT = 0,
	@RxId BIGINT=NULL,
	@RxDetailId BIGINT=NULL
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
	0 - None
	1 - RxHub
    2 - CAQH
    3 - Surescript
    4 - Medicare
    5 - Medicaid
*/
    -- Insert statements for procedure here
    IF ISNULL(@RxId,0)>0 AND ISNULL(@RxDetailId,0)>0
    BEGIN
		SELECT TOP 1 A.transaction_message_id TransactionMessageId, 
		A.pci_id CoverageID,
		A.ic_plan_name PlanName,
		A.card_holder_id CardHolderId,
		A.ic_plan_numb InsurancePlanID,
		A.ic_group_numb InsuranceGroupNumber,
		A.ic_group_name GroupName,
		A.ins_person_code InsurancePersonCode,
		A.ins_relate_code InsuranceRelateCode,
		A.formulary_id FormularyID,
		A.alternative_id AlternativeID,
		A.coverage_id CoverageListID,
		A.copay_id CopayID,
		A.pa_bin BinNumber,
		A.PCN PCN,
		A.pa_diff_info IsPBMPatientDiff,
		A.pbm_member_id MemberNumber,
		A.mail_order_coverage MailOrderCoverage,
		A.retail_pharmacy_coverage RetailCoverage,
		A.longterm_pharmacy_coverage LTCCoverage,
		A.specialty_pharmacy_coverage SpecialtyCoverage,
		A.ss_pbm_name ReturnedPBMName,
		A.rxhub_pbm_id PBMId,
		A.card_holder_first CardHolderFirstName,
		A.card_holder_last CardHolderLastName,
		A.card_holder_mi CardHolderMiddleName,
		A.PA_ADDRESS1 PatientAddress1,
		A.PA_ADDRESS2 PatientAddress2,
		A.PA_CITY PatientCity,
		A.PA_STATE PatientState,
		A.PA_ZIP PatientZip,
		A.PA_SEX PatientGender,
		A.PA_DOB PatientDOB,
		B.db_table_name FormularySourceDBTableName,
		B.fst_id CoverageSourceType,
		C.pbm_name PBMName,
		C.disp_string IdentificationString,
		C.disp_options DisplayOptions,
		C.pharmacy_id PharmacyId,
		C.is_gcn_based_form IsGCNBasedForm,
		CASE WHEN D.nonlist_brand IS NULL THEN -1 ELSE D.nonlist_brand END NonListBrand, 
		CASE WHEN D.nonlist_generic IS NULL THEN -1 ELSE D.nonlist_generic END NonListGeneric, 
		CASE WHEN D.otc_default IS NULL THEN -1 ELSE D.otc_default END NonListOTCBrand, 
		CASE WHEN D.generic_default IS NULL THEN -1 ELSE D.generic_default END NonListOTCGeneric, 
		CASE WHEN D.nonlist_supplies IS NULL THEN -1 ELSE D.nonlist_supplies END NonListSupplies,
		c.service_level PBMServiceLevel
		FROM prescriptions p WITH(NOLOCK) 
		INNER JOIN prescription_details pd WITH(NOLOCK)			ON p.PRES_ID=pd.PRES_ID 
		INNER JOIN prescription_coverage_info PC WITH(NOLOCK)	ON pd.PD_ID=PC.PD_ID 
		INNER JOIN patients_coverage_info A WITH(NOLOCK)		ON PC.pbm_id=A.rxhub_pbm_id
		INNER JOIN formularies..PBMS c WITH(NOLOCK)				ON A.rxhub_pbm_id = c.rxhub_part_id 
		LEFT OUTER JOIN FORMULARIES..formulary_source_types B with(nolock) ON A.formulary_type = fst_id 
		LEFT OUTER JOIN FORMULARIES..FORM_CROSS_REFERENCE D with(nolock) ON C.rxhub_part_id = D.rxhub_part_id AND PC.formulary_id = D.formulary_id
		WHERE PC.pd_id=@RxDetailId AND PC.formulary_id = A.formulary_id AND p.pa_id=A.pa_id
		 
    END
    ELSE
    BEGIN
		SELECT A.transaction_message_id TransactionMessageId, 
		A.pci_id CoverageID,
		A.ic_plan_name PlanName,
		A.card_holder_id CardHolderId,
		A.ic_plan_numb InsurancePlanID,
		A.ic_group_numb InsuranceGroupNumber,
		A.ic_group_name GroupName,
		A.ins_person_code InsurancePersonCode,
		A.ins_relate_code InsuranceRelateCode,
		A.formulary_id FormularyID,
		A.alternative_id AlternativeID,
		A.coverage_id CoverageListID,
		A.copay_id CopayID,
		A.pa_bin BinNumber,
		A.PCN PCN,
		A.pa_diff_info IsPBMPatientDiff,
		A.pbm_member_id MemberNumber,
		A.mail_order_coverage MailOrderCoverage,
		A.retail_pharmacy_coverage RetailCoverage,
		A.longterm_pharmacy_coverage LTCCoverage,
		A.specialty_pharmacy_coverage SpecialtyCoverage,
		A.ss_pbm_name ReturnedPBMName,
		A.rxhub_pbm_id PBMId,
		A.card_holder_first CardHolderFirstName,
		A.card_holder_last CardHolderLastName,
		A.card_holder_mi CardHolderMiddleName,
		A.PA_ADDRESS1 PatientAddress1,
		A.PA_ADDRESS2 PatientAddress2,
		A.PA_CITY PatientCity,
		A.PA_STATE PatientState,
		A.PA_ZIP PatientZip,
		A.PA_SEX PatientGender,
		A.PA_DOB PatientDOB,
		B.db_table_name FormularySourceDBTableName,
		B.fst_id CoverageSourceType,
		C.pbm_name PBMName,
		C.disp_string IdentificationString,
		C.disp_options DisplayOptions,
		C.pharmacy_id PharmacyId,
		C.is_gcn_based_form IsGCNBasedForm,
		CASE WHEN D.nonlist_brand IS NULL THEN -1 ELSE D.nonlist_brand END NonListBrand, 
		CASE WHEN D.nonlist_generic IS NULL THEN -1 ELSE D.nonlist_generic END NonListGeneric, 
		CASE WHEN D.otc_default IS NULL THEN -1 ELSE D.otc_default END NonListOTCBrand, 
		CASE WHEN D.generic_default IS NULL THEN -1 ELSE D.generic_default END NonListOTCGeneric, 
		CASE WHEN D.nonlist_supplies IS NULL THEN -1 ELSE D.nonlist_supplies END NonListSupplies,
		c.service_level PBMServiceLevel
		FROM patients PAT with(nolock)
		INNER JOIN patients_coverage_info A with(nolock) ON PAT.pa_id = A.pa_id
		LEFT OUTER JOIN FORMULARIES..formulary_source_types B with(nolock) ON formulary_type = fst_id 
		LEFT OUTER JOIN FORMULARIES..pbms C with(nolock) ON a.rxhub_pbm_id = c.rxhub_part_id
		LEFT OUTER JOIN FORMULARIES..FORM_CROSS_REFERENCE D with(nolock) ON C.rxhub_part_id = D.rxhub_part_id AND A.formulary_id = D.formulary_id
		WHERE PAT.pa_id = @PatientId  AND @HasNoFormulary=0 AND B.fst_id IN (1,2,3) --
		--AND PAT.dg_id = @GroupId
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
