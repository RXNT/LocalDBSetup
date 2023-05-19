SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author:		Thomas K
-- Create date: 31-Jan-2016
-- Description:	To get the RxNTEncounter template Details by group and doctor id
-- Modified By: JahabarYusuff M
-- Modified Date: 16-Sep-2019
-- ====================================================
CREATE PROCEDURE [enc].[usp_GetRxNTEncouterTemplateById]
	@DoctorId BIGINT,
	@TemplateId BIGINT,
	@DoctorGroupId	BIGINT = 0
AS

BEGIN
	SET NOCOUNT ON;
	/* 
	SELECT A.enc_tmpl_id, A.enc_name, A.enc_text, A.chief_complaint, A.enc_json
	FROM enchanced_encounter_templates A with(nolock) 
	WHERE A.dr_id = @DoctorId and A.enc_tmpl_id = @TemplateId
	*/
	SELECT  A.enc_tmpl_id, A.enc_name, A.enc_text, A.chief_complaint, A.enc_json
	FROM enchanced_encounter_templates A with(nolock) 
	left  OUTER JOIN doc_group_enhanced_encounter_templates B  with(nolock)  ON B.import_ref_id =a.enc_tmpl_id	 

	WHERE (A.dr_id = @DoctorId OR B.dg_id =@DoctorGroupId ) and A.enc_tmpl_id = @TemplateId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
