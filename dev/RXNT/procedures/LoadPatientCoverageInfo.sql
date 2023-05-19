SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Thomas K
-- Create date: March 20, 2016
-- Description:	Load patient coverage information
-- =============================================
CREATE PROCEDURE [dbo].[LoadPatientCoverageInfo]
(
	-- Add the parameters for the stored procedure here
	@PatientId	INT,
	@HasNoFormulary BIT = 0
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT * FROM (SELECT '' transaction_message_id, 
	A.pci_id pci_id,
	case when A.pbm_member_id is not null And LEN(A.pbm_member_id) > 1 THEN 
		A.ic_plan_name + ' [' + A.pbm_member_id + ']'
	else
	 A.ic_plan_name 
	end ic_plan_name ,
	A.card_holder_id card_holder_id,
	A.ic_plan_numb ic_plan_numb,
	A.ic_group_numb ic_group_numb,
	A.ic_group_name ic_group_name,
	A.ins_person_code ins_person_code,
	A.ins_relate_code ins_relate_code,
	A.formulary_id formulary_id,
	A.alternative_id alternative_id,
	A.coverage_id coverage_id,
	A.copay_id copay_id,
	A.pa_bin pa_bin,
	'' PCN,
	A.pa_diff_info pa_diff_info,
	A.pbm_member_id pbm_member_id,
	A.mail_order_coverage mail_order_coverage,
	A.retail_pharmacy_coverage retail_pharmacy_coverage,
	A.longterm_pharmacy_coverage longterm_pharmacy_coverage,
	A.specialty_pharmacy_coverage specialty_pharmacy_coverage,
	A.ss_pbm_name ss_pbm_name,
	A.rxhub_pbm_id rxhub_pbm_id,
	A.card_holder_first card_holder_first,
	A.card_holder_last card_holder_last,
	A.card_holder_mi card_holder_mi,
	A.PA_ADDRESS1 PA_ADDRESS1,
	A.PA_ADDRESS2 PA_ADDRESS2,
	A.PA_CITY PA_CITY,
	A.PA_STATE PA_STATE,
	A.PA_ZIP PA_ZIP,
	A.PA_SEX PA_SEX,
	A.PA_DOB PA_DOB,
	B.db_table_name,
	'1' fst_id,
	C.pbm_name pbm_name,
	C.disp_string disp_string,
	C.disp_options disp_options,
	C.pharmacy_id pharmacy_id,
	C.is_gcn_based_form,
	CASE WHEN D.nonlist_brand IS NULL THEN -1 ELSE D.nonlist_brand END nonlist_brand, 
	CASE WHEN D.nonlist_generic IS NULL THEN -1 ELSE D.nonlist_generic END nonlist_generic, 
	CASE WHEN D.otc_default IS NULL THEN -1 ELSE D.otc_default END otc_default, 
	CASE WHEN D.generic_default IS NULL THEN -1 ELSE D.generic_default END generic_default, 
	CASE WHEN D.nonlist_supplies IS NULL THEN -1 ELSE D.nonlist_supplies END nonlist_supplies,
	c.service_level,
	1 AS CoverageType
	FROM 
	patients PAT with(nolock) 
	INNER JOIN patients_coverage_info_external A with(nolock) ON PAT.pa_id = A.pa_id
	LEFT OUTER JOIN FORMULARIES..formulary_source_types B with(nolock) ON formulary_type = fst_id 
	LEFT OUTER JOIN FORMULARIES..pbms C with(nolock) ON A.rxhub_pbm_id = c.rxhub_part_id
	LEFT OUTER JOIN FORMULARIES..FORM_CROSS_REFERENCE D with(nolock) 
		ON C.rxhub_part_id = D.rxhub_part_id AND A.formulary_id = D.formulary_id
	WHERE PAT.pa_id = @PatientId
	--AND PAT.dg_id = @GroupId
		UNION
	SELECT A.transaction_message_id transaction_message_id, 
	A.pci_id pci_id,
	A.ic_plan_name ic_plan_name,
	A.card_holder_id card_holder_id,
	A.ic_plan_numb ic_plan_numb,
	A.ic_group_numb ic_group_numb,
	A.ic_group_name ic_group_name,
	A.ins_person_code ins_person_code,
	A.ins_relate_code ins_relate_code,
	A.formulary_id formulary_id,
	A.alternative_id alternative_id,
	A.coverage_id coverage_id,
	A.copay_id copay_id,
	A.pa_bin pa_bin,
	A.PCN PCN,
	A.pa_diff_info pa_diff_info,
	A.pbm_member_id pbm_member_id,
	A.mail_order_coverage mail_order_coverage,
	A.retail_pharmacy_coverage retail_pharmacy_coverage,
	A.longterm_pharmacy_coverage longterm_pharmacy_coverage,
	A.specialty_pharmacy_coverage specialty_pharmacy_coverage,
	A.ss_pbm_name ss_pbm_name,
	A.rxhub_pbm_id rxhub_pbm_id,
	A.card_holder_first card_holder_first,
	A.card_holder_last card_holder_last,
	A.card_holder_mi card_holder_mi,
	A.PA_ADDRESS1 PA_ADDRESS1,
	A.PA_ADDRESS2 PA_ADDRESS2,
	A.PA_CITY PA_CITY,
	A.PA_STATE PA_STATE,
	A.PA_ZIP PA_ZIP,
	A.PA_SEX PA_SEX,
	A.PA_DOB PA_DOB,
	B.db_table_name,
	B.fst_id fst_id,
	C.pbm_name pbm_name,
	C.disp_string disp_string,
	C.disp_options disp_options,
	C.pharmacy_id pharmacy_id,
	C.is_gcn_based_form,
	CASE WHEN D.nonlist_brand IS NULL THEN -1 ELSE D.nonlist_brand END nonlist_brand, 
	CASE WHEN D.nonlist_generic IS NULL THEN -1 ELSE D.nonlist_generic END nonlist_generic, 
	CASE WHEN D.otc_default IS NULL THEN -1 ELSE D.otc_default END otc_default, 
	CASE WHEN D.generic_default IS NULL THEN -1 ELSE D.generic_default END generic_default, 
	CASE WHEN D.nonlist_supplies IS NULL THEN -1 ELSE D.nonlist_supplies END nonlist_supplies,
	c.service_level,
	2 AS CoverageType
	FROM patients PAT with(nolock)
	INNER JOIN patients_coverage_info A with(nolock) ON PAT.pa_id = A.pa_id
	LEFT OUTER JOIN FORMULARIES..formulary_source_types B with(nolock) ON formulary_type = fst_id 
	LEFT OUTER JOIN FORMULARIES..pbms C with(nolock) ON a.rxhub_pbm_id = c.rxhub_part_id
	LEFT OUTER JOIN FORMULARIES..FORM_CROSS_REFERENCE D with(nolock) ON C.rxhub_part_id = D.rxhub_part_id AND A.formulary_id = D.formulary_id
	WHERE PAT.pa_id = @PatientId  AND @HasNoFormulary=0
	) a ORDER BY   CoverageType ASC
	--AND PAT.dg_id = @GroupId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
