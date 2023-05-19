SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author:		Nambi
-- Create date: 12-APR-2018
-- Description:	To get the Group RxNTEncounter template Details
-- Modified By: 
-- Modified Date: 
-- ====================================================
CREATE PROCEDURE [enc].[usp_GetDoctorGroupRxNTEncounterTemplateById]
	@DoctorGroupId BIGINT,
	@TemplateId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	/* SELECT A.enc_tmpl_id, A.enc_name, A.enc_text, A.chief_complaint, A.enc_json
	FROM doc_group_enhanced_encounter_templates A with(nolock) 
	WHERE A.dg_id = @DoctorGroupId and A.enc_tmpl_id = @TemplateId */
	
	SELECT  A.enc_tmpl_id, A.enc_name, A.enc_text, A.chief_complaint, A.enc_json
	FROM enchanced_encounter_templates A with(nolock) 
	left  OUTER JOIN doc_group_enhanced_encounter_templates B  with(nolock)  ON B.import_ref_id =a.enc_tmpl_id	 

	WHERE ( B.dg_id =@DoctorGroupId ) and A.enc_tmpl_id = @TemplateId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
