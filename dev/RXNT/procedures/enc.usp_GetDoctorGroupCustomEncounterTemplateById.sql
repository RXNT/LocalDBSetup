SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author:		Nambi
-- Create date: 12-APR-2018
-- Description:	To get the Group Custom Encounter template Details
-- Modified By: 
-- Modified Date: 
-- ====================================================
CREATE PROCEDURE [enc].[usp_GetDoctorGroupCustomEncounterTemplateById]
	@DoctorGroupId BIGINT,
	@TemplateId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT  A.enc_tmpl_id, A.enc_name, A.enc_text, A.enc_json   FROM  [encounter_templates]  A
	LEFT OUTER JOIN [doc_group_encounter_templates] et ON et.import_ref_id = A.enc_tmpl_id
	WHERE (et.dg_id = @DoctorGroupId   )  AND (A.enc_tmpl_id = @TemplateId OR et.enc_tmpl_id =@TemplateId)
	
	 
	
	 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
