SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ============================================= 
-- Author		: Nambi
-- Create date	: 01-AUG-2017
-- Description	: Enable V2 Dashboards for Companies and it's Users
-- ============================================= 
 
CREATE PROCEDURE [support].[EnableV2DashboardsForCompanies]
( 
	@DoctorCompanyId	INT,
	@EnableV2Dashboard BIT = NULL
) 
AS 
BEGIN 
	SET NOCOUNT ON; 
	-- Insert/Update on master database tables starts here 
	BEGIN 
		UPDATE	dbo.doc_companies 
		SET		is_custom_tester = ISNULL(@EnableV2Dashboard,0)
		WHERE	dc_id		       = @DoctorCompanyId 
	END
	IF @EnableV2Dashboard IS NOT NULL
		BEGIN
			IF @EnableV2Dashboard = 1
				BEGIN
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester ^ 1
					FROM doctor_info doc_info WITH(NOLOCK)
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
					AND (doc_info.is_custom_tester & 1) = 1 
					
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester | 4
					FROM doctor_info doc_info WITH(NOLOCK)
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
					AND (doc_info.is_custom_tester & 4) <> 4
					
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester | 8
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
					AND (doc_info.is_custom_tester & 8) <> 8
					
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester | 16
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
					AND (doc_info.is_custom_tester & 16) <> 16
					
					UPDATE doc_info
					SET encounter_version = 'v1.1'
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
				END
			ELSE
				BEGIN
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester ^ 4
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
					AND (doc_info.is_custom_tester & 4) = 4
					
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester ^ 8
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
					AND (doc_info.is_custom_tester & 8) = 8
					
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester ^ 16
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
					AND (doc_info.is_custom_tester & 16) = 16
					
					UPDATE doc_info
					SET is_custom_tester = doc_info.is_custom_tester | 1
					FROM doctor_info doc_info
					INNER JOIN doctors doc WITH(NOLOCK) ON doc_info.dr_id=doc.dr_id
					INNER JOIN doc_groups doc_grp WITH(NOLOCK) ON doc.dg_id=doc_grp.dg_id
					INNER JOIN doc_companies doc_cmp WITH(NOLOCK) ON doc_grp.dc_id=doc_cmp.dc_id
					WHERE doc_cmp.dc_id=@DoctorCompanyId AND doc_info.VersionURL = 'ehrv8'
					AND (doc_info.is_custom_tester & 1) <> 1
				END
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
