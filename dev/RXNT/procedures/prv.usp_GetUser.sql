SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Balaji
-- Create date: 12-Aug-2016
-- Description:	Get user details
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [prv].[usp_GetUser]
	@DoctorGroupId BIGINT,
	@UserId BIGINT
AS
BEGIN
		SELECT D.DR_FIRST_NAME,D.epcs_enabled,D.dr_enabled,D.loginlock, D.DR_PREFIX, D.DR_SUFFIX, d.hipaa_agreement_acptd,
		D.dr_agreement_acptd, d.dr_def_rxcard_history_back_to, d.dr_rxcard_search_consent_type, 
		D.dr_def_pat_history_back_to, D.NPI, D.TIME_DIFFERENCE, D.DR_MIDDLE_INITIAL, D.DR_LAST_NAME, D.DR_DEA_NUMB,
		D.DR_USERNAME,D.DR_ID, D.DG_ID, DG.DC_ID, DG.DG_NAME , D.DR_ADDRESS1, D.DR_ADDRESS2, D.DR_CITY,
		D.DR_STATE, D.DR_ZIP, D.DR_PHONE,D.DR_EMAIL, D.RIGHTS, D.DR_FAX, D.PRESCRIBING_AUTHORITY, dct.theme_id,dctx.theme_name, CASE WHEN main_doc.dr_id>0 THEN main_doc.dr_id WHEN ISNULL(main_doc.dr_id,0)<=0 AND d.prescribing_authority=4 THEN D.dr_id ELSE NULL END AS dr_last_alias_dr_id,
		aut_doc.dr_id AS dr_last_auth_dr_id,DI.is_custom_tester
		FROM DOCTORS D WITH(NOLOCK)
		LEFT OUTER JOIN doctor_info DI WITH(NOLOCK) ON D.dr_id = DI.dr_id
		LEFT OUTER JOIN doctors main_doc WITH(NOLOCK) ON D.dr_last_alias_dr_id=main_doc.dr_id AND main_doc.dr_enabled=1 
		LEFT OUTER JOIN doctors aut_doc WITH(NOLOCK) ON D.dr_last_auth_dr_id=aut_doc.dr_id AND aut_doc.dr_enabled=1 
		INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON D.DG_ID = DG.DG_ID 
		LEFT JOIN doc_company_themes dct WITH(NOLOCK) on dg.dc_id = dct.dc_id
		LEFT JOIN DOC_COMPANY_THEMES_XREF dctx WITH(NOLOCK) on dct.theme_id = dctx.theme_id
		WHERE D.dr_id=@UserId AND D.DG_ID = @DoctorGroupId  AND D.DR_ENABLED = 1 and D.loginlock = 0 
		and D.lowusage_lock = 0 AND (D.billing_enabled=0 or (D.billing_enabled=1 and D.billingDate > getdate()))
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
