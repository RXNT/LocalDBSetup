SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 25-May-2016
-- Description:	To update the custom encounter form
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_UpdateCustomEncounterModel]
	@FormID BIGINT,
	@JSON NVARCHAR(MAX)
AS

BEGIN
	SET NOCOUNT ON;
	UPDATE emd SET emd.json_definition = @JSON
	FROM encounter_model_definitions emd WITH(NOLOCK)
	INNER JOIN encounter_types et WITH(NOLOCK) ON emd.type = et.enc_type 
	INNER JOIN encounter_form_settings efs WITH(NOLOCK) ON et.enc_type =efs.type
	WHERE efs.enc_type_id = @FormID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
