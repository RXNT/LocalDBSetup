SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author	: Rasheed
-- Create date	: 15-MAR-2016
-- Description	: To update the RxNTEncounter template Details
-- Modified By	: 
-- Modified Date: 
-- ====================================================
CREATE PROCEDURE [enc].[usp_UpdateRxNTEncouterTemplate]
	@DoctorId		BIGINT,
	@TemplateId		BIGINT,
	@EncTextJSON	NVARCHAR(MAX)
AS

BEGIN
	SET NOCOUNT ON;
	UPDATE enchanced_encounter_templates
	SET enc_json = @EncTextJSON
	WHERE dr_id = @DoctorId AND enc_tmpl_id = @TemplateId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
