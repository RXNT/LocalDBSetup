SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author		: Rasheed
-- Create date	: 04-APR-2016
-- Description	: To update the Custom Encounter template Details
-- Modified By	: 
-- Modified Date: 
-- ====================================================
CREATE PROCEDURE [enc].[usp_UpdateCustomEncouterTemplate]
	@DoctorId		BIGINT,
	@TemplateId		BIGINT,
	@EncTextJSON	NVARCHAR(MAX)
AS

BEGIN
	SET NOCOUNT ON;
	UPDATE encounter_templates
	SET enc_json = @EncTextJSON
	WHERE dr_id = @DoctorId AND enc_tmpl_id = @TemplateId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
