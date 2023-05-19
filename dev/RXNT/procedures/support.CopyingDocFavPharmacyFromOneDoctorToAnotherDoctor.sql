SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CopyingDocFavPharmacyFromOneDoctorToAnotherDoctor]
	@DoctorCompanyId	INT,
	@FromDoctorId		INT,
	@ToDoctorId			INT
AS	
BEGIN	 
	INSERT INTO doc_site_fav_pharms (dr_id, pharm_id)
	select DISTINCT @ToDoctorId,dsfp_from.pharm_id FROM doc_site_fav_pharms dsfp_from
	INNER JOIN doctors d WITH(NOLOCK) ON d.dr_id = dsfp_from.dr_id
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = d.dg_id
	LEFT OUTER JOIN doc_site_fav_pharms dsfp_to WITH(NOLOCK)   ON dsfp_to.dr_id = @ToDoctorId AND dsfp_from.pharm_id=dsfp_to.pharm_id
	WHERE dsfp_from.dr_id=@FromDoctorId AND dg.dc_id=@DoctorCompanyId AND dsfp_to.pharm_id IS NULL
	 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
