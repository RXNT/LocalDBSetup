SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CopyingDocFavScriptsFromOneDoctorToAnotherDoctor]	
	@DoctorCompanyId	INT,
	@FromDoctorId		INT,
	@ToDoctorId			INT
AS	
BEGIN 
	INSERT INTO doc_fav_scripts (dr_id, ddid, dosage, use_generic, numb_refills, duration_unit, 
			duration_amount, comments, prn, as_directed, update_code, drug_version, prn_description, 
			compound, days_supply, drug_indication)
	SELECT DISTINCT @ToDoctorId,dfs_from.ddid, dfs_from.dosage, dfs_from.use_generic, dfs_from.numb_refills, dfs_from.duration_unit, 
			dfs_from.duration_amount, dfs_from.comments, dfs_from.prn, dfs_from.as_directed, dfs_from.update_code, dfs_from.drug_version, dfs_from.prn_description, 
			dfs_from.compound, dfs_from.days_supply, dfs_from.drug_indication
	FROM doc_fav_scripts dfs_from
	INNER JOIN doctors d WITH(NOLOCK) ON d.dr_id = dfs_from.dr_id
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = d.dg_id
	LEFT OUTER JOIN doc_fav_scripts dfs_to WITH(NOLOCK)   ON dfs_to.dr_id = @ToDoctorId AND dfs_from.ddid = dfs_to.ddid AND dfs_from.dosage = dfs_to.dosage AND dfs_from.use_generic = dfs_to.use_generic AND dfs_from.numb_refills = dfs_to.numb_refills AND dfs_from.duration_unit = dfs_to.duration_unit AND dfs_from.duration_amount = dfs_to.duration_amount AND dfs_from.comments=dfs_to.comments AND dfs_from.prn=dfs_to.prn AND dfs_from.as_directed=dfs_to.as_directed AND dfs_from.update_code=dfs_to.update_code AND dfs_from.drug_version=dfs_to.drug_version AND dfs_from.prn_description = dfs_to.prn_description AND dfs_from.compound = dfs_to.compound AND dfs_from.days_supply=dfs_to.days_supply AND dfs_from.drug_indication=dfs_to.drug_indication
	WHERE dfs_from.dr_id=@FromDoctorId AND dg.dc_id=@DoctorCompanyId	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
