SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CopyingDocFavDrugsFromOneDoctorToAnotherDoctor]
	@DoctorCompanyId	INT,
	@FromDoctorId		INT,
	@ToDoctorId			INT
AS	
BEGIN
	INSERT INTO doc_fav_drugs (dr_id, drug_id)
	SELECT DISTINCT @ToDoctorId,dfd_from.drug_id FROM doc_fav_drugs dfd_from
	INNER JOIN doctors d WITH(NOLOCK) ON d.dr_id = dfd_from.dr_id
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = d.dg_id
	LEFT OUTER JOIN doc_fav_drugs dfd_to WITH(NOLOCK)   ON dfd_to.dr_id = @ToDoctorId AND dfd_from.drug_id=dfd_to.drug_id
	WHERE dfd_from.dr_id=@FromDoctorId AND dg.dc_id=@DoctorCompanyId AND dfd_to.drug_id IS NULL
	
	 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
