SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff
-- Create date: 03-Jan-2018
-- Description:	To get the Custom Encounter templates
-- Modified By: 
-- Modified Date: 13-Sep-2019
-- Description:	load all subtemplates including groups
-- =============================================
CREATE  PROCEDURE [ehr].[usp_GetCustomEncouterTemplates]
	@FormId BIGINT,
	@DoctorId BIGINT,
	@DoctorGroupId	BIGINT = 0
AS

BEGIN
	SET NOCOUNT ON;
	/* SELECT DISTINCT  c.enc_tmpl_id, c.enc_name, 0 AS GroupTemplate FROM encounter_form_settings a
	INNER JOIN encounter_types b WITH(NOLOCK) ON a.type = b.enc_type
	INNER JOIN encounter_model_definitions d ON a.type= d.type
	INNER JOIN [encounter_templates] c WITH(NOLOCK) ON c.enc_type_id = d.model_defn_id AND a.dr_id = c.dr_id
	WHERE a.enc_type_id=@FormId AND a.dr_id = @DoctorId
	
	UNION
	SELECT DISTINCT c.enc_tmpl_id, c.enc_name, 1 AS GroupTemplate FROM encounter_form_settings a
	INNER JOIN encounter_types b WITH(NOLOCK) ON a.type = b.enc_type
	INNER JOIN encounter_model_definitions d ON a.type= d.type
	INNER JOIN [doc_group_encounter_templates] c WITH(NOLOCK) ON c.enc_type_id = d.model_defn_id
	INNER JOIN doctors dr WITH(NOLOCK) ON a.dr_id=dr.dr_id AND dr.dg_id=@DoctorGroupId 
	WHERE a.enc_type_id=@FormId AND c.dg_id = @DoctorGroupId

	ORDER BY c.enc_name */
	
	
	SELECT DISTINCT  c.enc_tmpl_id, c.enc_name, 
	
	case when ISNULL(et.import_ref_id, '') = '' then '' else 1 END AS GroupTemplate
	  FROM  [encounter_templates]  c
	LEFT OUTER JOIN [doc_group_encounter_templates] et ON et.import_ref_id = c.enc_tmpl_id
	INNER JOIN encounter_model_definitions dGRP ON (et.enc_type_id = dGRP.model_defn_id	  OR c.enc_type_id = dGRP.model_defn_id)
	INNER JOIN encounter_types bGRP WITH(NOLOCK) ON dGRP.type = bGRP.enc_type
	INNER JOIN encounter_form_settings aGRP WITH(NOLOCK) ON aGRP.type = bGRP.enc_type	
	WHERE (et.dg_id = @DoctorGroupId OR c.dr_id = @DoctorId) AND aGRP.enc_type_id=@FormId

	ORDER BY c.enc_name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
