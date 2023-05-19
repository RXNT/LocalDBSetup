SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author:		Rasheed
-- Create date: 12-Apr-2016
-- Description:	To get the Custom Encounter template Details by group and doctor id
-- Modified By: JahabarYusuff M
-- Modified Date: 16-Sep-2019 
-- ====================================================
CREATE PROCEDURE [enc].[usp_GetCustomEncouterTemplateById]
	@DoctorId BIGINT,
	@TemplateId BIGINT,
	@DoctorGroupId	BIGINT = 0
	
AS

BEGIN
	SET NOCOUNT ON;
	/* SELECT A.enc_tmpl_id, A.enc_name, A.enc_text, A.enc_json
	FROM encounter_templates A with(nolock) 
	WHERE A.dr_id = @DoctorId and  A.enc_tmpl_id = @TemplateId */
		SELECT  c.enc_tmpl_id, c.enc_name, c.enc_text, c.enc_json   FROM  [encounter_templates]  c
	LEFT OUTER JOIN [doc_group_encounter_templates] et ON et.import_ref_id = c.enc_tmpl_id
	WHERE (et.dg_id = @DoctorGroupId  OR c.dr_id = @DoctorId)  AND (c.enc_tmpl_id = @TemplateId OR et.enc_tmpl_id =@TemplateId)
	
	 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
