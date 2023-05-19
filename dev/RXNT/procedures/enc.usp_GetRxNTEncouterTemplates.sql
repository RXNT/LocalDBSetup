SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 20-Jan-2016
-- Description:	To get the RxNTEncounter template Details by group and doctor id
-- Modified By: JahabarYusuff M
-- Modified Date: 16-Sep-2019
-- =============================================
CREATE PROCEDURE [enc].[usp_GetRxNTEncouterTemplates]
	@DoctorId		BIGINT,
	@DoctorGroupId	BIGINT = 0
AS

BEGIN
	SET NOCOUNT ON;
	/*SELECT A.enc_tmpl_id, A.enc_name, A.chief_complaint, 0 AS GroupTemplate FROM enchanced_encounter_templates A 
	with(nolock) 
	WHERE A.dr_id = @DoctorId
	UNION
	SELECT A.enc_tmpl_id, A.enc_name, A.chief_complaint, 1 AS GroupTemplate FROM doc_group_enhanced_encounter_templates A 
	with(nolock) 
	WHERE A.dg_id = @DoctorGroupId
	ORDER BY A.chief_complaint */
	
	SELECT  A.enc_tmpl_id,A.enc_name  , B.import_ref_id,
	case when ISNULL(B.import_ref_id, '') = '' then '' else 1 END AS GroupTemplate	 FROM enchanced_encounter_templates A 	with(nolock) 
	left  OUTER JOIN doc_group_enhanced_encounter_templates B  with(nolock)  ON B.import_ref_id =a.enc_tmpl_id	 
	WHERE A.dr_id =@DoctorId OR B.dg_id =@DoctorGroupId
	ORDER BY A.enc_name
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
