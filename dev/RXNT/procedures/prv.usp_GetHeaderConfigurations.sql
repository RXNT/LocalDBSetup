SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 2-APR-2021
-- Description:	Get permission based configurations needed for header
-- =============================================
CREATE PROCEDURE [prv].[usp_GetHeaderConfigurations]
    @DoctorId BIGINT,
    @DoctorCompanyId BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT doc.PRESCRIBING_AUTHORITY AS 'prescribing_authority',
        CASE WHEN addr.OwnerEntityID > 0 THEN 1 ELSE 0 END AS 'has_direct_email',
        doc.rights,
        doc.dr_id,
        doc.dr_first_name,
        doc.dr_last_name,
        doc.dr_middle_initial,
        doc.professional_designation,
        grp.dg_name,
        main_doc.dr_first_name AS 'main_dr_first_name',
        main_doc.dr_last_name AS 'main_dr_last_name',
        main_doc.dr_middle_initial AS 'main_dr_middle_initial',
        main_doc.professional_designation AS 'main_dr_professional_designation',
        auth_doc.dr_first_name AS 'auth_dr_first_name',
        auth_doc.dr_last_name AS 'auth_dr_last_name',
        auth_doc.dr_middle_initial AS 'auth_dr_middle_initial',
        auth_doc.professional_designation AS 'auth_dr_professional_designation',
        CASE WHEN main_doc.dr_id > 0
			THEN main_doc.dr_id
		WHEN ISNULL(main_doc.dr_id, 0) <= 0 AND doc.prescribing_authority = 4 
			THEN doc.dr_id ELSE NULL 
	    END AS dr_last_alias_dr_id,
        auth_doc.dr_id AS dr_last_auth_dr_id,
		dctx.theme_name
    from doctors doc WITH(NOLOCK)
        left outer join doctors main_doc WITH(NOLOCK) on doc.dr_last_alias_dr_id = main_doc.dr_id AND main_doc.dr_enabled = 1
        left outer join doctors auth_doc WITH(NOLOCK) on doc.dr_last_auth_dr_id = auth_doc.dr_id AND auth_doc.dr_enabled = 1
        inner join doc_groups grp WITH(NOLOCK) on grp.dg_id = doc.dg_id
        inner join doc_companies cmp WITH(NOLOCK) on cmp.dc_id = grp.dc_id
        LEFT OUTER join direct_email_addresses addr WITH(NOLOCK) ON addr.OwnerEntityID = doc.dr_id AND addr.DirectAddressOwnerType=1
		LEFT JOIN doc_company_themes dct WITH(NOLOCK) on grp.dc_id = dct.dc_id
		LEFT JOIN DOC_COMPANY_THEMES_XREF dctx WITH(NOLOCK) on dct.theme_id = dctx.theme_id
    where doc.dr_id=@DoctorId and cmp.dc_id=@DoctorCompanyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
